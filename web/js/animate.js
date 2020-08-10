var box=document.getElementById('box');var arr=document.getElementById('arr');var left=document.getElementById('left');var right=document.getElementById('right');var screen=box.children[0];var ul=screen.children[0];var ol=screen.children[1];var lis=ul.children;for(var i=0;i<lis.length;i++){var li=document.createElement('li');li.index=i;li.onclick=liclick;if(i==0){li.className='current';}
ol.appendChild(li);}
var liwidth=screen.offsetWidth;function liclick(){for(var i=0;i<ol.children.length;i++){ol.children[i].className='';}
this.className='current';index=this.index;animate(ul,-index*liwidth);}
box.onmouseenter=function(){arr.style.display='block';clearInterval(move);}
box.onmouseleave=function(){arr.style.display='none';move=setInterval(function(){right.click();},2000)}
var index=0;left.onclick=function(){if(index===0){index=lis.length-1;ul.style.left=-index*liwidth+'px';}
index--;ol.children[index].click();}
right.onclick=function(){if(index===lis.length-1){ul.style.left='0px';index=0;}
index++;if(index<lis.length-1){ol.children[index].click();}else{animate(ul,-index*liwidth);for(var i=0;i<ol.children.length;i++){var li=ol.children[i];li.className='';}
ol.children[0].className='current';}}
var first=ul.children[0];var cloneli=first.cloneNode(true);ul.appendChild(cloneli);var move=setInterval(function(){right.click();},2000)
function animate(element,target){if(element.timerId){clearInterval(element.timerId);element.timerId=null;}
element.timerId=setInterval(function(){var step=10;var current=element.offsetLeft;if(current>target){step=-Math.abs(step);}
if(Math.abs(current-target)<=Math.abs(step)){clearInterval(element.timerId);element.style.left=target+'px';return;}
current+=step;element.style.left=current+'px';},5);}