/**
 * Created by Administrator on 2016/12/15.
 */
$(function(){
    $('input, textarea').placeholder();
    /*��¼tabҳת��*/
    $(".content-list").click(function(){
        $(".content-list").removeClass("content-list-select");
        $(this).addClass("content-list-select");
        var index=$(this).index();
        $(".login-name").addClass("all-block-none");
        $(".login-name:eq("+index+")").removeClass("all-block-none")
    })
    /*����input������ɫ�ı仯�������placeholder���ݵĻ�����ɫΪǳ��ɫ������Ϊ��ɫ*/
    $("input").bind("focus",function(){
        $(this).css("color","#666");
    }).bind("blur",function(){
        var placetext=$(this).attr("placeholder");
        if($(this).val()!=""){
            if($(this).val()!=placetext){
                $(this).css("color","#666");
            }else{
                $(this).css("color","#999");
            }
        }else{
            $(this).css("color","#999");
        }
    })

    /*�������ľ����͵��֮�󱳾�ɫ�ı仯*/
    /*�������Ԫ�����ѡ�б�־*/
    $(".nav-list").on("click",function(){
        $(".nav-list").removeClass("navselectflag");
        $(this).addClass("navselectflag");
    })
    /*������Ԫ�� ɾ������Ԫ�ص�ѡ��״̬ ����ǰԪ�����ѡ��״̬������*/
    $(".nav-list").on("mouseover",function(){
        $(".nav-selected").removeClass("nav-selected");
        $(this).addClass("nav-selected");
    });
    /*����뿪 ��ѡ��״̬����ɾ��*/
    $(".nav-list").on("mouseout",function(){
        $(".nav-selected").removeClass("nav-selected");
    });
    /*����뿪������ ����ѡ�б�־�����ѡ��״̬������*/
    $(".nav-lists").on("mouseleave",function(){
        $(".navselectflag").addClass("nav-selected")
    })

})