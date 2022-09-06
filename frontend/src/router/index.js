import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    // 홈 페이지
    // path: '/',
    // name: 'home',
    // component: () => import('@/views/HomeView.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router
