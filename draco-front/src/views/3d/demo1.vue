<template>
  <layout-box title="快速起步" description="相机、场景。">
    <div id="box"></div>
  </layout-box>
</template>

<script>
import * as THREE from 'three'

export default {
  mounted () {
    // https://threejs.org/docs/index.html#manual/zh/introduction/Creating-a-scene
    const width = 900
    const height = 600
    const box = document.querySelector('#box')
    const scene = new THREE.Scene()
    // 设置背景色
    scene.background = new THREE.Color('gray')
    // PerspectiveCamera（视野角度、长宽比、相机距离物体最近距离、相机距离物体最远距离）
    const camera = new THREE.PerspectiveCamera(75, width / height, 0.1, 1000)

    // 渲染器，用来添加各种模型、环境光等
    const renderer = new THREE.WebGLRenderer()
    // 设置分辨率
    renderer.setSize(width, height)
    box.appendChild(renderer.domElement)

    // BoxGeometry：立方体对象
    const geometry = new THREE.BoxGeometry()
    // MeshBasicMaterial：材质，这里是给立方体对象添加一个材质
    const material = new THREE.MeshBasicMaterial({ color: 0x00ff00 })
    // Mesh：网格对象，包含一个几何体以及作用在此几何体上的材质，我们可以直接将网格对象放入到我们的场景中，并让它在场景中自由移动。
    const cube = new THREE.Mesh(geometry, material)
    scene.add(cube)

    // 物体在 z 轴上的缩放值
    camera.position.z = 5

    const animate = function () {
      requestAnimationFrame(animate)

      cube.rotation.x += 0.01
      cube.rotation.y += 0.01

      // 挂载
      renderer.render(scene, camera)
    }

    animate()
  }
}
</script>

<style lang="less" scoped>

</style>
