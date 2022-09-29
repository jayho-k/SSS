<template>
  <div class="RevisionMenuBox">
    <label for="video_file"><div  @change="upload_add" class="metalBtn hoverB linearBtn" ><span class="material-symbols-outlined">drive_folder_upload</span><input  type="file" id="video_file" style="width: 0px; height: 0px;"  @change="showTextFile"  accept=".mp4, .mkv"></div></label>
    <div class="metalBtn hoverR linearBtn" @click="del"><span class="material-symbols-outlined">
delete
</span></div>




  </div>
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo';
export default {
  setup() {
    const uploadStore = useUploadVideoStore()
    function upload_add (event) { 
      Object.values(event.target.files).forEach(item => {

        uploadStore.uploadVideo(item)
      })
    }

    return {
      upload_add,
    }
  }
}
</script>

<style>
.RevisionMenuBox {
  justify-content: center;
  text-align: center;
  display: flex;
  width: 120px;
  height: 28px;
  border-radius: 5px;
  align-items: center;
}



</style>