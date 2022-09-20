import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/cctv',
    name: 'cctv',
    component: () => import('@/views/cctv/cctvMainView.vue')
  },
  {
    path: '/upload',
    name: 'upload',
    component: () => import('@/views/uploadVideo/uploadVideoView.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
