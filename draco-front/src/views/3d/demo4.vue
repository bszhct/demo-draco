<template>
  <layout-box title="压缩展示" description="转成 draco 格式的版本，压缩质量对比。">
    <div class="PB12">
      <a-button v-for="(item, i) in levels" :key="item.path" class="MR10 MB10" @click="drawModel(i, item, $refs[`box-${i}`])">
        {{item.name}}
      </a-button>
    </div>
    <div class="FBH FBWW">
      <div v-for="(item, i) in levels" :key="item.path" :ref="`box-${i}`" class="model-box">
        <div class="show-level" v-if="i === 0">源文件，加载耗时：{{item.time}}s</div>
        <div class="show-level" v-else>压缩等级：{{i}}，加载耗时：{{item.time}}s</div>
        <a-spin class="loading-box" size="large" :spinning="item.loading"></a-spin>
      </div>
    </div>
  </layout-box>
</template>

<script>
import * as THREE from 'three'
import { OBJLoader } from 'three/examples/jsm/loaders/OBJLoader'
import { DRACOLoader } from 'three/examples/jsm/loaders/DRACOLoader'
import { MTLLoader } from 'three/examples/jsm/loaders/MTLLoader'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls'

function changeMaterialEmissive (parent) {
  parent.traverse(function (obj) {
    if (obj instanceof THREE.Mesh) {
      obj.material.emissive = new THREE.Color(1, 1, 1)
      obj.material.emissiveIntensity = 1
      obj.material.emissiveMap = obj.material.map
    }
  })
}

export default {
  data () {
    const levels = [{
      name: '展示源文件',
      path: '/model/egg/6a.obj',
      time: '--',
      loading: false
    }, {
      name: '展示 1 级压缩',
      path: '/model/egg-zip/6a-1.drc',
      time: '--',
      loading: false
    }, {
      name: '展示 2 级压缩',
      path: '/model/egg-zip/6a-2.drc',
      time: '--',
      loading: false
    }, {
      name: '展示 3 级压缩',
      path: '/model/egg-zip/6a-3.drc',
      time: '--',
      loading: false
    }, {
      name: '展示 4 级压缩',
      path: '/model/egg-zip/6a-4.drc',
      time: '--',
      loading: false
    }, {
      name: '展示 5 级压缩',
      path: '/model/egg-zip/6a-5.drc',
      time: '--',
      loading: false
    }, {
      name: '展示 6 级压缩',
      path: '/model/egg-zip/6a-6.drc',
      time: '--',
      loading: false
    }, {
      name: '展示 7 级压缩',
      path: '/model/egg-zip/6a-7.drc',
      time: '--',
      loading: false
    }, {
      name: '展示 8 级压缩',
      path: '/model/egg-zip/6a-8.drc',
      time: '--',
      loading: false
    }, {
      name: '展示 9 级压缩',
      path: '/model/egg-zip/6a-9.drc',
      time: '--',
      loading: false
    }, {
      name: '展示 10 级压缩',
      path: '/model/egg-zip/6a-10.drc',
      time: '--',
      loading: false
    }, {
      name: '展示 11 级压缩',
      path: '/model/egg-zip/6a-11.drc',
      time: '--',
      loading: false
    }]
    return {
      levels
    }
  },
  methods: {
    drawModel (i, item, box) {
      console.log('drawModel =>', i, item, box)

      const width = 400
      const height = 400
      const scene = new THREE.Scene()
      scene.background = new THREE.Color('#191919')
      const camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000)
      camera.position.set(0, 10, 20)

      const renderer = new THREE.WebGLRenderer()
      renderer.setSize(width, height)
      box[0].appendChild(renderer.domElement)

      // 轨道控制器
      const controls = new OrbitControls(camera, renderer.domElement)
      controls.target.set(0, 1, 0)
      controls.update()

      function render () {
        renderer.render(scene, camera)
      }
      render()

      // 监听鼠标事件，触发渲染函数，更新 canvas 画布渲染效果
      controls.addEventListener('change', render)

      // 开启环境光
      // const skyColor = 0xB1E1FF
      // const groundColor = 0xB97A20
      // const intensity = 1
      // const light = new THREE.HemisphereLight(skyColor, groundColor, intensity)
      // scene.add(light)

      // 加载鸡蛋模型
      item.loading = true
      let materialLoader = null
      let modelLoader = null
      let materialPath = ''
      const t = Date.now()
      const isObjModel = item.path.match(/\.obj$/)
      if (isObjModel) {
        materialLoader = new MTLLoader()
        materialLoader.setPath('/model/egg/')
        materialPath = '6a.mtl'

        modelLoader = new OBJLoader()
      } else {
        materialLoader = new THREE.TextureLoader()
        materialPath = '/model/egg/6a.jpg'

        modelLoader = new DRACOLoader()
        modelLoader.setDecoderPath('/model/egg-zip/')
        modelLoader.setDecoderConfig({ type: 'js' })
      }

      materialLoader.load(materialPath, (texture) => {
        if (isObjModel) {
          modelLoader.setMaterials(texture)
        }
        modelLoader.load(item.path, (model) => {
          console.log('模型信息')
          console.log(model)

          item.loading = false

          if (isObjModel) {
            const light = new THREE.SpotLight(0xffffff)
            light.position.set(0, -3, 4)
            light.target = model
            scene.add(light)

            changeMaterialEmissive(model)
            const box = new THREE.Box3().setFromObject(model)
            const center = new THREE.Vector3()
            box.getCenter(center)
            model.position.sub(center)
            camera.position.set(10, 100, 200)
            scene.add(model)
            setTimeout(() => {
              render()
            }, 100)
          } else {
            model.computeVertexNormals()

            const material = new THREE.MeshBasicMaterial({
              map: texture
            })
            const mesh = new THREE.Mesh(model, material)
            mesh.castShadow = true
            mesh.receiveShadow = true

            const box = new THREE.Box3().setFromObject(mesh)
            const center = new THREE.Vector3()
            box.getCenter(center)
            camera.position.set(10, 100, 200)
            scene.add(mesh)
            mesh.position.sub(center)
            modelLoader.dispose()
          }

          render()

          item.time = (Date.now() - t) / 1000
          console.log('耗时')
          console.log(item.time)
        })
      })
    }
  }
}
</script>

<style lang="less" scoped>
.model-box {
  width: 400px;
  height: 400px;
  margin-right: 10px;
  margin-bottom: 10px;
  flex-shrink: 0;
  border: 1px solid #d9d9d9;
  position: relative;
  .loading-box {
    position: absolute;
    top: 200px;
    left: 200px;
    transform: translate(-50%, -50%);
  }
  .show-level {
    position: absolute;
    left: 0;
    padding: 2px 4px;
    color: #fff;
  }
}
</style>
