<template>
  <div class="RevisionMenuBox">
    <div  @click="upload_add" class="Revisionbutton"><input  type="file" id="contract_file" style="opacity: 100%;" multiple @change="showTextFile"  accept=".mp4, .mkv">Upload</div>
    <div class="Revisionbutton" @click="move">조건</div>
    <div class="Revisionbutton" @click="del">삭제</div>

  </div>
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo';
export default {
  setup() {
    const uploadStore = useUploadVideoStore()
    function upload_add () {
      console.log(uploadStore.VideoList)
    }

    return {
      upload_add,
    }
  }
}
</script>

<style>

.RevisionMenuBox {
    display: flex;
    width: 320px;
    height: 90px;
    border-radius: 5px;
    justify-content: space-between;
    align-items: center;
}
.Revisionbutton {
    display: flex;
    width: 100px;
    height: 72px;
    background-color: var(--main-color2);
    border-radius: 5px;
    align-items: center;
    justify-content: center;
}
::file-selector-button {
  display: none;
}
</style>