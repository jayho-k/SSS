//const HOST = "http://localhost:8000/"
// const HOST = "http://j7b302.p.ssafy.io/api/"
const ACCOUNTS = "accounts/"

// export default {
//     accounts: {
//       login: () => HOST + ACCOUNTS + "user/login/",
//       reissuance: ()=> HOST + ACCOUNTS + "user/token/reissuance/",
//       logout: ()=> HOST + ACCOUNTS + "user/logout/",
//       findId:()=> HOST + ACCOUNTS + "user/find/id/",
//       signup: () => HOST + ACCOUNTS + "user/signup/" ,
//       userManage: () => HOST + ACCOUNTS + 'user/',
//     },
//     managerLogin: {
//       passwordChange:() => HOST + ACCOUNTS + "user/password/",
//       approveSignup:()=> HOST + ACCOUNTS + "admin/approval/",
//       activateList:()=> HOST + ACCOUNTS + "admin/activate/",
//       deactivateList:()=> HOST + ACCOUNTS + "admin/deactivate/",
//       searchUserList: () => HOST + ACCOUNTS + "admin/search/",
//       // resetPassWord:()=> HOST + ACCOUNTS + "admin/reset/password",
//     },
    
//   }

  export default {
    accounts: {
      login: () => ACCOUNTS + "user/login/",
      reissuance: ()=>   ACCOUNTS + "user/token/reissuance/",
      logout: ()=>   ACCOUNTS + "user/logout/",
      findId:()=>   ACCOUNTS + "user/find/id/",
      signup: () =>   ACCOUNTS + "user/signup/" ,
      userManage: () =>   ACCOUNTS + 'user/',
    },
    managerLogin: {
      passwordChange:() =>   ACCOUNTS + "user/password/",
      approveSignup:()=>   ACCOUNTS + "admin/approval/",
      activateList:()=>   ACCOUNTS + "admin/activate/",
      deactivateList:()=>   ACCOUNTS + "admin/deactivate/",
      searchUserList: () =>   ACCOUNTS + "admin/search/",
      // resetPassWord:()=>   ACCOUNTS + "admin/reset/password",
    },
    
  }