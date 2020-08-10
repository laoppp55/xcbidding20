// JavaScript Document
var $menu=jQuery.noConflict();
$menu(document).ready(function(){
  
			
  $menu('.subnav_ul li').mousemove(function(){
  $menu(this).find('div.subnav_down').show();//you can give it a speed
  });
  $menu('.subnav_ul li').mouseleave(function(){
  $menu(this).find('div.subnav_down').hide();
  });
  $menu('.subnav_down_dl').find('dd span:first').css("background","none");  
  
});