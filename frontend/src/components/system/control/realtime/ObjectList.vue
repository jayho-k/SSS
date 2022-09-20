<template>
	<div class="ObjectListBox">
        <div class=""></div>
        <ObjectMenu></ObjectMenu>
		<ObjectItem v-for="(D_item, D_i) in DataSet"
    :key="D_i"
    :D_item = D_item
    @click="mapCenter(D_i)"></ObjectItem>
	</div>
</template>

<script>
import { useKakoStore } from '@/stores/kakaoMap';
import ObjectMenu from '@/components/system/control/realtime/ObjectMenu'
import ObjectItem from '@/components/system/control/realtime/ObjectItem'
export default {
    components: {
        ObjectMenu,
        ObjectItem
    },
    setup () {
      const kakaostore = useKakoStore()
      const DataSet = kakaostore.saved_markers_info
      function mapCenter (D_i) {
        kakaostore.setMapCenter(D_i)
      }
      return {
        kakaostore,
        DataSet,
        mapCenter
      }
    }
  

}
</script>

<style>
.ObjectListBox {
    width: 320px;
    height: 480px;
    background-color: var(--main-color2);
}
</style>