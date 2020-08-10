// JavaScript Document
var $menu=jQuery.noConflict();
$menu(document).ready(function(){
  
			
  $menu('.subnav0_ul li').mousemove(function(){
  $menu(this).find('div.subnav0_down').show();//you can give it a speed
  });
  $menu('.subnav0_ul li').mouseleave(function(){
  $menu(this).find('div.subnav0_down').hide();
  });
  $menu('.subnav0_down_dl').find('dd span:first').css("background","none");  
  
});