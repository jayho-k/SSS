<template>
	<div class="ObjectListBox">
        <div class=""></div>
        <ObjectMenu></ObjectMenu>
		<ObjectItem v-for="R_D in testData"
    :key="R_D"></ObjectItem>
	</div>
</template>

<script>
import ObjectMenu from '@/components/system/control/ObjectMenu'
import ObjectItem from '@/components/system/control/ObjectItem'
export default {
    components: {
        ObjectMenu,
        ObjectItem
    },
    setup() {
        const testData = [1, 2, 3, 4]
        
        return {
            testData
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