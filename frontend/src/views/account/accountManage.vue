<template>
  <header>
    <v-card color="grey lighten-4" flat height="200px">
      <v-toolbar :dark="bar.dark"> 
        <!-- :color="bar.class"  -->
       
        <v-toolbar-title>회원 관리</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn icon>
          <v-icon>mdi-magnify</v-icon>
        </v-btn>
        <v-btn icon>
          <v-icon>mdi-logout</v-icon>
        </v-btn>
      </v-toolbar>
    </v-card>
  </header>
  <body>
    <template>
        <v-data-table
          :headers="headers"
          :items="contents"
          :items-per-page="10"
          class="elevation-1"
        ></v-data-table>
      </template>
  </body>
</template>


<script>
// import { useAccounts } from "@/stores/accounts";
// import { ref } from "vue"
  export default {
    name:'manageTable',
    data () {
      return {
       headers: [
       {
       text: '이름',
       align: 'start',
       sortable: false,
       value: 'name',
       },
      {
       text: '기관/기업명',
       align: 'start',
       sortable: false,
       value: 'corpName',
       },
       {
       text: '담당자 번호',
       align: 'start',
       sortable: false,
       value: 'userPhoneNum',
       },
       {
       text: '이메일',
       align: 'start',
       sortable: false,
       value: 'email',
       },
       {
       text: '아이디',
       align: 'start',
       sortable: false,
       value: 'ID',
       },
       {
       text: '',
       align: 'start',
       sortable: false,
       value: 'passwordReset',
       },
       {
       text: '',
       align: 'start',
       sortable: false,
       value: 'accountDelete',
       },

       ],
       contents: [
          {
            name:'-',
            corpName: '-',
            userPhoneNum: '-',
            email: '-',
            ID: '-',
            passwordReset: '-',
            accountDelete: '-',
          },
        ],
      }
    },
  }

</script>