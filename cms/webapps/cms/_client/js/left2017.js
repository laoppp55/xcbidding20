/**
 * Created by Administrator on 2017/3/21.
 */
$(function(){
    /*�����б�������ͣ�¼�*/
    $(".center-left").on("mouseover",".left_lists",function(e){
        $(".l-lists-big").css("backgroundColor","#fff");
        $(this).find(".l-lists-big").css("backgroundColor","#e3f0f8");
        e.stopPropagation()
    });
    $(".center-left").on("mouseout",".left_lists",function(e){
        $(this).find(".l-lists-big").css("backgroundColor","#fff");
        $(".list-select").css("backgroundColor","#e3f0f8");
        e.stopPropagation()
    })
})
