/*! www.vancheer.com  |  Powered by vancheer */
$(function(){
	//--
	$('.indexPart4').find('.more').click(function(){
		$('.indexPart4').find('.list').toggleClass('autoh');
		$('.indexPart4').find('.more').toggleClass('on');
		})
	//--
	$('.news1').find('li').find('.title').find('a').each(function (i) {
        $(this).hover(
		   function () {
				$('.news1').find('li').find('.time').eq(i).addClass('on');
		   },
		   function () {
			   $('.news1').find('li').find('.time').eq(i).removeClass('on');
		   }
		)
    })
	$('.search1').find('li').find('.title').find('a').each(function (i) {
        $(this).hover(
		   function () {
				$('.search1').find('li').find('.time').eq(i).addClass('on');
		   },
		   function () {
			   $('.search1').find('li').find('.time').eq(i).removeClass('on');
		   }
		)
    })
//	$('.lnav').find('li').each(function(i){
//		$(this).click(function(){
//			$('.lnav').find('li').removeClass('liNow');
//			$(this).addClass('liNow');
//			$('body,html').stop().animate({scrollTop: $('.projectDiv').eq(i).offset().top-0}, 500,'easeOutQuart');
//			})
//	})
//	//--
//	if($('.lnav').length>0){
//		$(window).scroll(function(){
//			if($(window).scrollTop()>$('.projectDiv').offset().top){
//				$('.lnav').addClass('projectNow');
//				}else{
//					$('.lnav').removeClass('projectNow');
//					}
//			$('.projectDiv').each(function(i){
//				if($(window).scrollTop()>=$(this).offset().top){
//					$('.lnav').find('li').removeClass('liNow');
//					$('.lnav').find('li').eq(i).addClass('liNow');
//					}
//				})
//			})
//		}
//	//--
//	$('.pagenavph').find('.now').click(function(){
//		$('.pagenavph').find('.list').fadeToggle();
//		$('.pagenavph').find('.now').toggleClass('blak');
//		})
//	//--
//	$('.toplistph').find('.title').click(function(){
//		$('.toplistph').find('ul').fadeToggle();
//		})
	//--
	$('.headDiv').find('.searchph').click(function(){
		$('.phsearch').fadeToggle(500);
		})
	$('.phsearch').find('.phsearchbg').click(function(){
		$('.phsearch').fadeOut(500);
		})
	//--
	$('.navIco').click(function(){
		$('.navLayer').animate({right: "0",width:"100%"}, 500);
		})
	$('.navLayer').find('.close').click(function(){
		$('.navLayer').animate({right: "-100%",width:0}, 500);
		})
	$('.navLayer').find('.ico').click(function(){
		$('.navLayer').animate({right: "-100%",width:0}, 500);
		})
	//--
//	$('.jod1').find('.list').find('li').hover(
//		function(){
//		$(this).prev().addClass('bg');
//		},
//		function(){
//		$(this).prev().removeClass('bg');
//		}
//	)
//	$('.partner1').find('.plist').find('li').hover(
//		function(){
//		$(this).prev().addClass('bg');
//		},
//		function(){
//		$(this).prev().removeClass('bg');
//		}
//	)
	//--
	$('.tabContentDiv').find('.tabContent:first').show();
	$('.tab').each(function(i){
		$(this).find('li').each(function(ii){
			$(this).hover(
			function(){
				$('.tab').eq(i).find('li').removeClass('liNow');
				$(this).addClass('liNow');
				$('.tabContentDiv').eq(i).find('.tabContent').hide();
				$('.tabContentDiv').eq(i).find('.tabContent').eq(ii).show();
				},
			function(){}	
				)
			})
		})
	//--
	$('.tabContentDiv2').find('.tabContent2:first').show();
	$('.tab2').each(function(i){
		$(this).find('li').each(function(ii){
			$(this).click(
			function(){
				$('.tab2').eq(i).find('li').removeClass('liNow');
				$(this).addClass('liNow');
				$('.tabContentDiv2').eq(i).find('.tabContent2').hide();
				$('.tabContentDiv2').eq(i).find('.tabContent2').eq(ii).show();
				}	
				)
			})
		})
	//--
//	$('.tabmap').each(function(i){
//		$(this).find('.imgbox').each(function(ii){
//			$(this).click(
//			function(){
//				$('.tabmap').eq(i).find('.imgbox').removeClass('imgNow');
//				$(this).addClass('imgNow');
//				$('.tabContentmap').eq(i).find('.content').hide();
//				$('.tabContentmap').eq(i).find('.content').eq(ii).show();
//				}	
//				)
//			})
//		})
//	$('.tabContentmap').find('.close').click(function(){
//		$('.tabContentmap').find('.content').hide();
//		$('.map').find('.imgbox').removeClass('imgNow');
//		})
	//--
//	$('.phNav').find('.titleTop').click(function(){
//		$('.phNav').find('ul').toggle();	
//		})
//	
//	$('.headDiv').find('.searchph').click(function(){
//		$('.searchLayerTel').toggle();
//		$('.searchBg').toggle();
//		})
//	$('.searchBg').click(function(){
//		$('.searchLayerTel').hide();
//		$('.searchBg').hide();	
//		})
	//--
	$('.sNavA').each(function(i){
		$(this).hover(
		   function(){
			   $('.sNav').eq(i).css('left',$(this).offset().left);
			   $('.sNav').eq(i).show();
			   },
		   function(){
			   $('.sNav').hide();
			   }
		)
		})
	$('.sNav').each(function(i){
		$(this).hover(
		   function(){
			   $('.sNavA').eq(i).addClass('aNow');
			   $(this).show();
			   },
		   function(){
			   $('.sNavA').removeClass('aNow');
			   $(this).hide();
			   }
		)
		})	
		
	//--
	$(".subNav").click(function(){
			$(this).toggleClass("currentDt").siblings(".subNav").removeClass("currentDt")
			$(this).next(".navContent").slideToggle(300).siblings(".navContent").slideUp(500)
	})
	//--
	$(".subNav2").click(function(){
			$(this).toggleClass("currentDt2").siblings(".subNav2").removeClass("currentDt2")
			$(this).next(".navContent2").slideToggle(300).siblings(".navContent2").slideUp(500)
	})
	//--
	//--
	
	//--
	$('.sideBar').hover(
	   function(){
		   $(this).find('ul').show();
		   },
	   function(){
		   $(this).find('ul').hide();
		   }
	)
	$('.sideBar').find('li').hover(
	   function(){
		   $(this).addClass('liNow');
		   },
	   function(){
		   $(this).removeClass('liNow');
		   }
	)


    //--
	$('.codebox').find('.ico').hover(
	   function () {
	       $('.codebox').find('.ico').toggleClass('on');
	       $('.codebox').find('.con').show();
	   }
	)
	$('.codebox').find('.con').hover(
	   function () {
	       $(this).show();
	       $('.codebox').find('.ico').addClass('on');
	   },
		   function () {
		       $(this).hide();
		       $('.codebox').find('.ico').removeClass('on');
		   }
	)
	//--返回顶部
	if($('.topA').length>0){
		$(window).scroll(function(){
			if($(window).scrollTop()>200){
				$('.topA').fadeIn(200);
				}else{
					$('.topA').fadeOut(200);
					}
			})
		}
	$('.topA').click(function(){
		$('body,html').animate({scrollTop: 0}, 500);

		})
    //--
	if ($('.codebox').length > 0) {
	    $(window).scroll(function () {
	        if ($(window).scrollTop() > 500) {
	            $('.codebox').fadeIn(200);
	        } else {
	            $('.codebox').fadeOut(200);
	        }
	    })
	}
    //--
	if ($('.pre-box1').length > 0) {
	    $(window).scroll(function () {
	        if ($(window).scrollTop() < 300) {
	            $('.pre-box1').fadeIn(200);
	        } else {
	            $('.pre-box1').fadeOut(200);
	        }
	    })
	}
	$('.sideBar').find('li').hover(
	   function(){
		   $(this).addClass('liNow');
		   },
	   function(){
		   $(this).removeClass('liNow');
		   }
	)
	//
})
	



jQuery(document).ready(function($){
	// browser window scroll (in pixels) after which the "back to top" link is shown
	var offset = 300,
		//browser window scroll (in pixels) after which the "back to top" link opacity is reduced
		offset_opacity = 1200,
		//duration of the top scrolling animation (in ms)
		scroll_top_duration = 700,
		//grab the "back to top" link
		$back_to_top = $('.cd-top');

	//hide or show the "back to top" link
	$(window).scroll(function(){
		( $(this).scrollTop() > offset ) ? $back_to_top.addClass('cd-is-visible') : $back_to_top.removeClass('cd-is-visible cd-fade-out');
		if( $(this).scrollTop() > offset_opacity ) { 
			$back_to_top.addClass('cd-fade-out');
		}
	});

	//smooth scroll to top
	$back_to_top.on('click', function(event){
		event.preventDefault();
		$('body,html').animate({
			scrollTop: 0 ,
		 	}, scroll_top_duration
		);
	});

});	

function search() {
        var keys = document.getElementById("txtk").value;
        location.href = "/NewsCenter/search.aspx?a=n&keys=" + keys;
    }
    function entersearch() {
        //alert(dd);
        var keys = document.getElementById("txtk").value;
        var event = window.event || arguments.callee.caller.arguments[0];
        if (event.keyCode == 13) {
            //search();
            window.location.href = "/NewsCenter/search.aspx?a=n&keys=" + keys;
            return false;
        }
    }


