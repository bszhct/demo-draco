import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [{
  path: '/',
  redirect: '/demo1'
}, {
  path: '/demo1',
  component: () => import('@/views/3d/demo1.vue')
}, {
  path: '/demo2',
  component: () => import('@/views/3d/demo2.vue')
}, {
  path: '/demo3',
  component: () => import('@/views/3d/demo3.vue')
}, {
  path: '/demo4',
  component: () => import('@/views/3d/demo4.vue')
}]

const router = new VueRouter({
  base: process.env.BASE_URL,
  mode: 'history',
  routes
})

export default router
