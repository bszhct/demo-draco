<template>
  <layout-box title="加载 3D 模型" description="模型加载。">
    <div id="box"></div>
  </layout-box>
</template>

<script>
import * as THREE from 'three'
import { OBJLoader } from 'three/examples/jsm/loaders/OBJLoader'
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls'

export default {
  mounted () {
    const width = 900
    const height = 600
    const box = document.querySelector('#box')
    const scene = new THREE.Scene()
    scene.background = new THREE.Color('gray')
    const camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000)
    camera.position.set(0, 10, 20)

    const renderer = new THREE.WebGLRenderer()
    renderer.setSize(width, height)
    box.appendChild(renderer.domElement)

    // 轨道控制器，可以使得相机围绕目标进行轨道运动。
    const controls = new OrbitControls(camera, renderer.domElement)
    controls.target.set(0, 1, 0)
    controls.update()

    // 添加半球光
    const skyColor = 0xB1E1FF // 蓝色
    const groundColor = 0xB97A20 // 橙色
    const intensity = 1
    // 半球光（不能投射阴影）
    const light = new THREE.HemisphereLight(skyColor, groundColor, intensity)
    scene.add(light)

    const objLoader = new OBJLoader()
    objLoader.load('https://threejsfundamentals.org/threejs/resources/models/windmill/windmill.obj', (root) => {
      console.log('root =======>')
      console.log(root)
      const box = new THREE.Box3().setFromObject(root)
      const center = new THREE.Vector3()
      box.getCenter(center)
      // 设置模型始终在中心点显示
      root.position.sub(center)
      // 缩放模型大小
      root.scale.set(8, 8, 8)
      // 旋转模型
      // root.rotation.y = Math.PI
      // 移动相机距离
      camera.position.set(10, 100, 200)
      scene.add(root)
    })

    function render () {
      renderer.render(scene, camera)
      requestAnimationFrame(render)
    }
    requestAnimationFrame(render)
  }
}
</script>

<style lang="less" scoped>

</style>
