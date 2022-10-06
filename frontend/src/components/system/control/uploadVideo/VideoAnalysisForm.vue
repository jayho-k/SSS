<template>
	<div v-if="uploadStore.is_analysis_video">
				
		<select class="select" id="select" @change="select_case" name="job">
			<option value="">선택</option>
			<option value="fire">화재감지 영상분석</option>
			<option value="mia">미아탐색 영상분석</option>
			<option value="safety">공공안전 영상분석</option>
		</select>


		<div style="display:flex;	justify-content: space-around; margin-top:10px;">
			<div></div>
			<div @click="start_detecting" class="light-button button-wrapper">
				<div class="buttonB">
					<span class="span">
						<span v-if="uploadStore.analysis_case === 'fire'" class="material-symbols-outlined">local_fire_department</span>
						<span v-if="uploadStore.analysis_case === 'mia'" class="material-symbols-outlined">face</span>
						<span v-if="uploadStore.analysis_case === 'safety'" class="material-symbols-outlined">sports_kabaddi</span>
						<div>분석</div>
					</span>
				</div>  
			</div>

			<div  @click="toggle_form" class="light-button button-wrapper">
				<div class="buttonR">
					<span class="span">
				
						<div>취소</div>
					</span>
				</div>  
			</div>
			<div></div>
		</div>
	</div>
</template>

<script>
import { useUploadVideoStore } from '@/stores/uploadVideo'
export default {
	setup() {
		const uploadStore = useUploadVideoStore()
		function select_case (event) {
			uploadStore.analysis_case = event.target.value
		}
		function start_detecting () {
			uploadStore.uploadVideo()
      uploadStore.is_analysis_video = !uploadStore.is_analysis_video
		}
		function toggle_form() {
			uploadStore.is_analysis_video = !uploadStore.is_analysis_video
		}
		
		return {
				uploadStore,
				select_case,
				start_detecting,
				toggle_form,
		}


	}

}
</script>

<style>
.buttonB {
    background: #fff;
    border: none;
    padding: 4px;
    cursor: pointer;
    display: block;
    position: relative;
    overflow: hidden;
    transition: all .2s ease-in-out .2s;
    margin: 0 auto;
    width: 84px;
    text-align: center;
    height: 32px;
  }
  .buttonB:hover .span {
    background: var(--sweet-blue);
    color: #fff;
    transition: all .2s ease-in-out .2s;
  }
  .buttonB:after {
    bottom: -100%;
    right: -100%;
    content: "";
    width: 100%;
    height: 100%;
    position: absolute;
    background: var(--sweet-blue);
    transition: all .2s ease-in-out .5s;
  }
  .buttonB:hover:after {
    right: 0;
    bottom: 0;
    transition: all ease-in-out .2s;
  }
  .buttonB:before {
    top: -100%;
    left: -100%;
    content: "";
    width: 100%;
    height: 100%;
    position: absolute;
    background: var(--sweet-blue);
    transition: all .2s ease-in-out .5s;
  }
  .buttonB:hover:before {
    left: 0;
    top: 0;
    transition: all ease-in-out .2s;
  }

	.buttonR {
    background: #fff;
    border: none;
    padding: 4px;
    cursor: pointer;
    display: block;
    position: relative;
    overflow: hidden;
    transition: all .2s ease-in-out .2s;
    margin: 0 auto;
    width: 84px;
    text-align: center;
    height: 32px;
  }
  .span {
		display: flex;
		justify-content: center;
		align-items: center;
    padding: 4px 4px 4px 4px;
    background: #fff;
    z-index: 100;
    height: 24px;
    width: 76px;
    position: relative;
    transition: all .2s ease-in-out .2s;
    font-size: 16px;
  }
.button-wrapper {
    display: inline-block;
  }
  .buttonR:hover .span {
    background: var(--sweet-red);
    color: #fff;
    transition: all .2s ease-in-out .2s;
  }
  .buttonR:after {
    bottom: -100%;
    right: -100%;
    content: "";
    width: 100%;
    height: 100%;
    position: absolute;
    background: var(--sweet-red);
    transition: all .2s ease-in-out .5s;
  }
  .buttonR:hover:after {
    right: 0;
    bottom: 0;
    transition: all ease-in-out .2s;
  }
  .buttonR:before {
    top: -100%;
    left: -100%;
    content: "";
    width: 100%;
    height: 100%;
    position: absolute;
    background: var(--sweet-red);
    transition: all .2s ease-in-out .5s;
  }
  .buttonR:hover:before {
    left: 0;
    top: 0;
    transition: all ease-in-out .2s;
  }
	.select {
		width: 204px;
		height: 40px;
		font-size: 16px;
		margin-top: 20%;
    margin-left: 24px;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 3px solid #aaa;
    background-color: #ffffff;
    background-size: contain;
    background-repeat: no-repeat;
    background-position: center;
	}
</style>