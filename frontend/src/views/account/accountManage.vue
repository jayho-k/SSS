<template>
  <Suspense>
    <template #default>
      <accountList />
    </template>
    <template #fallback>
      Account List is loading...
    </template>
  </Suspense>
</template>

<script>
import accountList from '@/views/account/components/accountList.vue'
export default {
  components: {
    accountList
  },
}
</script>

<style>

</style>

