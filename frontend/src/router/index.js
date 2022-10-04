import { createRouter, createWebHistory } from 'vue-router'


const routes = [
  {
    path: '/cctv',
    name: 'cctv',
    component: () => import('@/views/cctv/cctvMainView.vue')
  },
  {
    path: '/',
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
    component: () => import('@/views/account/components/accountList.vue')
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
    component: () => import('@/views/uploadVideo/VideoPlayView.vue')
  },
  {
    path: '/please/Login',
    name: 'plzLogin',
    component: () => import('@/views/LoginErrorPage.vue')
  },
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
  
})
// router.beforeEach(function (to, from, next) {
//   // to: 이동할 url에 해당하는 라우팅 객체

//   console.log(from)
//   if (localStorage.getItem('token') === '' || localStorage.getItem('token') === null) {
//     if ( to.path === '/'|| to.path === '/please/Login') {
//       next()
//     } else {
//       console.log('not Login')
//       next('/please/Login')
//     }
//     // router.replace('VideoPlayer')
//   }  else {
//     next(); // 페이지 전환
//   }
// });
export default router
