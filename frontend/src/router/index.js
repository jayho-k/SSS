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
  {
    path: '/myPage',
    name: 'myPage',
    component: () => import('@/views/account/components/myPage.vue')
  },
  {
    path: '/upload',
    name: 'upload',
    component: () => import('@/views/uploadVideo/uploadVideoView.vue')
  },
  {
    path: '/VideoPlayer',
    name: 'VideoPlayer',
    component: () => import('@/components/system/uploadVideo/VideoPlayer.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
  
})
// 로우터가드 to, from, next
export default router
