import { createRouter, createWebHistory } from 'vue-router'

const routes = [
  {
    path: '/cctv',
    name: 'cctv',
    component: () => import('@/views/cctv/cctvMainView.vue')
  },
  {
    path: '/login',
    name: 'login',
    component: () => import('@/views/account/loginView.vue')
  },
  {
    path: '/signup',
    name: 'signup',
    component: () => import('@/views/account/signUpView.vue')
  },
  {
    path: '/accountManage',
    name: 'accountManage',
    component: () => import('@/views/account/accountManage')
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
  
})
// 로우터가드 to, from, next
export default router
