
const Koa = require('koa')
const Router = require('koa-router')
const koaBody = require('koa-body')
const fs = require('fs')
const {execSync} = require('child_process')
const path = require('path')
// const moment = require('moment')

const app = new Koa()
const router = new Router()
const port = 3000

app.use(koaBody({
  multipart: true,
  formidable: {
    maxFileSize: 1000 * 1024 * 1024 // 1GB，默认 2M
  }
}))

// 模型存放地址
// 最大的 200m 左右，一般 50～100 的比较多，185M 转化时间 
const modelRootPath = `${process.cwd()}/models/`

router
  .get('/', (ctx, next) => {
    ctx.response.type = 'html'
    ctx.body = fs.readFileSync(process.cwd() + '/test.html')
  })
  .all('/drc', (ctx, next) => {
    // 多个文件
    const files = ctx.request.files.files
    const newFiles = Array.isArray(files) ? files : [files]

    if (!newFiles.length) {
      return ctx.body = {
        code: 602,
        data: files,
        message: '没有接收到文件'
      }
    }

    // const dirPath = path.join(modelRootPath, `${moment().format('YYYY/MM/DD')}/`)
    const dirPath = modelRootPath
    const drcPath = `${dirPath + (newFiles[0].name.split('.').shift())}.drc`
    // 最终放回的文件路径
    const res = {
      objPath: '',
      mtlPath: '',
      imgPath: '',
      drcPath
    }

    for (let file of newFiles) {
      try {
        const filePath = path.join(dirPath, file.name)
        const reader = fs.createReadStream(file.path)
        // 创建可写流
        const upStream = fs.createWriteStream(filePath)
        // 可读流通过管道写入可写流
        reader.pipe(upStream)
        if (/\.obj$/.test(file.name)) {
          res.objPath = filePath
        } else if (/\.mtl$/.test(file.name)) {
          res.mtlPath = filePath
        } else if (/\.(png|jpg|jpeg)$/.test(file.name)) {
          res.imgPath = filePath
        }
      } catch (error) {
        console.error(error)
        return ctx.body = {
          code: 602,
          message: '文件上传失败'
        }
      }
    }

    // obj 转 drc
    try {
      const t = Date.now()
      // 185M 文件 8s 左右转换完成
      if (res.objPath) {
        execSync(`${process.cwd()}/draco_encoder -i ${res.objPath} -o ${drcPath} -cl 10`)
      }
      console.log('间隔时间 =>')
      console.log(`${(Date.now() - t) / 1000}s`)
    } catch (error) {
      console.error(error)
      return ctx.body = {
        code: 602,
        message: 'obj 转 drc 失败'
      }
    }

    console.log('data =>')
    console.log(res)
    
    return ctx.body = {
      code: 0,
      data: res
    }
  })

app
  .use(router.routes())
  .use(router.allowedMethods())

app.listen(port, () => {
  console.log(`服务启动成功：http://0.0.0.0:${port}`)
})
