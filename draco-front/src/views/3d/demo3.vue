<template>
  <layout-box title="自定义配置" description="模型加载、模型切换、打开性能检测、缩放">
    <div class="PB16">
      <div class="PB12">
        <span>性能检测</span>
        <a-button class="ML10" @click="onOpenPerformance()">打开</a-button>
      </div>
      <div class="PB12">
        <span>模型切换</span>
        <a-button v-for="item in models" :key="item.path" :type="item.path === activeModel.path ? 'primary' : 'default'" class="ML10" @click="onModelChange(item)">
          {{item.name}}
        </a-button>
      </div>
      <div class="PB12">
        <span>灯光切换</span>
        <a-button v-for="item in lights" :key="item.type" :type="item.type === activeLight.type ? 'primary' : 'default'" class="ML10" @click="onLightChange(item)">
          {{item.name}}
        </a-button>
      </div>
    </div>
    <div id="box" class="model-box">
      <a-spin class="loading-box" size="large" :spinning="loading"></a-spin>
    </div>
  </layout-box>
</template>

<script>
import * as THREE from 'three'
import { OBJLoader } from 'three/examples/jsm/loaders/OBJLoader'
import { MTLLoader } from 'three/examples/jsm/loaders/MTLLoader'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls'
import Stats from 'three/examples/jsm/libs/stats.module'

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
    return {
      // 模型切换加载状态
      loading: false,
      // 模型列表
      models: [{
        path: '/model/plane/', objName: '1.obj', materialName: '1.mtl', name: '飞机'
      }, {
        path: '/model/well/', objName: 'well.obj', materialName: 'well.mtl', name: '古井'
      }],
      activeModel: {
        path: '/model/well/', objName: 'well.obj', materialName: 'well.mtl', name: '古井'
      },
      // 相机
      camera: null,
      // 场景
      scene: null,
      // 容器
      box: null,
      // 性能监视器
      stats: null,
      // 当前显示的模型
      model: null,
      // 当前光线
      light: null,
      // 支持的光线列表
      lights: [{
        type: 1, name: '环境光'
      }, {
        type: 2, name: '点光源'
      }, {
        type: 3, name: '聚光灯'
      }, {
        type: 4, name: '平行光'
      }, {
        type: 5, name: '半球光'
      }],
      // 当前选中的光线
      activeLight: {}
    }
  },
  mounted () {
    const width = 900
    const height = 600
    // gray/blank
    const backgroundColor = 'black'
    const box = document.querySelector('#box')
    const scene = new THREE.Scene()
    scene.background = new THREE.Color(backgroundColor)
    this.scene = scene
    this.box = box

    const camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000)
    camera.position.set(0, 10, 20)
    this.camera = camera

    const renderer = new THREE.WebGLRenderer()
    renderer.setSize(width, height)
    box.appendChild(renderer.domElement)

    // 轨道控制器
    const controls = new OrbitControls(camera, renderer.domElement)
    controls.target.set(0, 1, 0)
    controls.update()

    const mtlLoader = new MTLLoader()
    const objLoader = new OBJLoader()

    mtlLoader.setPath(this.activeModel.path)
    mtlLoader.load(this.activeModel.materialName, (materials) => {
      console.log('材质')
      console.log(materials)

      objLoader.setMaterials(materials)
      objLoader.setPath(this.activeModel.path)
      objLoader.load(this.activeModel.objName, (model) => {
        changeMaterialEmissive(model)
        console.log('模型信息')
        console.log(model)
        this.model = model
        scene.add(model)
        this.loading = false
      })
    })

    const render = () => {
      renderer.render(scene, camera)
      if (this.stats) {
        this.stats.update()
      }
      requestAnimationFrame(render)
    }
    requestAnimationFrame(render)
  },
  methods: {
    // 打开性能检测
    onOpenPerformance () {
      if (!this.stats) {
        // 创建一个性能监视器
        const stats = new Stats()
        this.stats = stats
        stats.domElement.style.position = 'absolute'
        stats.domElement.style.left = '0px'
        stats.domElement.style.top = '0px'
        this.box.appendChild(stats.domElement)
      }
    },
    // 切换模型
    onModelChange (item) {
      if (item.path === this.activeModel.path) {
        return
      }
      this.loading = true
      this.activeModel = item
      this.scene.remove(this.model)

      const mtlLoader = new MTLLoader()
      const objLoader = new OBJLoader()

      mtlLoader.setPath(this.activeModel.path)
      mtlLoader.load(this.activeModel.materialName, (materials) => {
        console.log('材质')
        console.log(materials)

        objLoader.setMaterials(materials)
        objLoader.setPath(this.activeModel.path)
        objLoader.load(this.activeModel.objName, (model) => {
          changeMaterialEmissive(model)
          console.log('模型信息')
          console.log(model)
          this.model = model
          model.scale.set(3, 3, 3)
          this.scene.add(model)
          this.loading = false
        })
      })
    },
    // 光线切换
    onLightChange (item) {
      if (this.light) {
        this.scene.remove(this.light)
      }
      this.activeLight = item
      switch (item.type) {
        // 添加环境光
        case 1: {
          const light = new THREE.AmbientLight(0x158dff)
          this.light = light
          this.scene.add(light)
          break
        }
        // 添加点光源
        case 2: {
          const light = new THREE.PointLight(0x158dff, 2, 100)
          light.position.set(0, 1.5, 2)
          this.light = light
          this.scene.add(light)
          break
        }
        // 添加聚光灯
        case 3: {
          const light = new THREE.SpotLight(0x158dff)
          light.position.set(0, -3, 4)
          light.target = this.model
          this.light = light
          this.scene.add(light)
          break
        }
        // 添加平行光
        case 4: {
          const light = new THREE.DirectionalLight()
          light.position.set(2, 5, 3)
          this.light = light
          this.scene.add(light)
          break
        }
        // 添加半球光
        case 5: {
          const skyColor = 0xB1E1FF
          const groundColor = 0xB97A20
          const intensity = 1
          const light = new THREE.HemisphereLight(skyColor, groundColor, intensity)
          this.light = light
          this.scene.add(light)
          break
        }
      }
    }
  }
}
</script>

<style lang="less" scoped>
.model-box {
  width: 900px;
  height: 600px;
  position: relative;
  .loading-box {
    position: absolute;
    top: 300px;
    left: 450px;
    transform: translate(-50%, -50%);
  }
}
</style>
