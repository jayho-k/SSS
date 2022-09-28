<template>
	<div class="watchBox metalWatch"></div>
</template>

<script>
export default {

}
</script>

<style>
.watchBox {
	width: 260px;
	height: 60px;
	border-radius: 5px;
}
.metalWatch {
  display: flex;
  justify-content: center;
  align-items: center;
  text-align: center;
  color: hsla(0,0%,20%,1);
  text-shadow: hsla(0,0%,40%,.5) 0 -1px 0, hsla(0,0%,100%,.6) 0 2px 1px;
  
  background-color: hsl(0,0%,90%);
  box-shadow: inset hsla(0,0%,15%,  1) 0  0px 0px 4px, /* border */
    inset hsla(0,0%,15%, .8) 0 -1px 5px 4px, /* soft SD */
    inset hsla(0,0%,0%, .25) 0 -1px 0px 6px, /* bottom SD */
    inset hsla(0,0%,100%,.7) 1px  1px 1px 6px, /* top HL */
    
    hsla(0,0%, 0%,.15) 0 -3px 4px 4px, /* outer SD */
    hsla(0,0%,100%,.5) 0  1px 4px 4px; /* outer HL */ 
  
  transition: color .2s;
}
</style>