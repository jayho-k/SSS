<template>
	<div class="ObjectListBox">
    
    <ObjectMenu></ObjectMenu>
    <div style="overflow-y:scroll; overflow-x:hidden; width:280px; height:420px;">

		<ObjectItem v-for="(D_item, D_i) in DataSet"
    :key="D_i"
    :D_item = D_item
    @click="mapCenter(D_i)"></ObjectItem>
    </div>
	</div>
</template>

<script>
import { useKakaoStore } from '@/stores/kakaoMap';
import ObjectMenu from '@/components/system/control/realtime/ObjectMenu'
import ObjectItem from '@/components/system/control/realtime/ObjectItem'
export default {
    components: {
        ObjectMenu,
        ObjectItem
    },
    setup () {
      const kakaostore = useKakaoStore()
      const DataSet = kakaostore.saved_markers_info
      function mapCenter (D_i) {
        kakaostore.setMapCenter(D_i)
      }
      return {
        DataSet,
        mapCenter
      }
    }
  

}
</script>

<style>
.ObjectListBox {
    width: var(--controller-width);
    height: 480px;
    background-color: var(--main-color2);
}

</style>