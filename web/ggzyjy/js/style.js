// JavaScript Document
// 有更多的方法
function g(o){return document.getElementById(o);}
function Hovertab_m(num,counts,tabname,tabclass,tabcolor){
    for (i=1;i<=counts;i++)
    {
        g(tabname+'tab0'+i).className=tabclass+' ';
        g(tabname+'div0'+i).style.display='none';
        g(tabname+'more0'+i).style.display='None';
    }
    g(tabname+'tab0'+num).className=tabclass+'act' ;
    g(tabname+'div0'+num).style.display='block';
    g(tabname+'more0'+num).style.display='block';

}

// 没有更多，只有列表
function Hovertab(num,counts,tabname,tabclass,tabcolor){
    for (i=1;i<=counts;i++)
    {
        g(tabname+'tab0'+i).className=tabclass+' ';
        g(tabname+'div0'+i).style.display='none';
    }
    g(tabname+'tab0'+num).className=tabclass+'act' ;
    g(tabname+'div0'+num).style.display='block';
}

// 没有更多，也没列表
function Hovertab_nolist(num,counts,tabname,tabclass,tabcolor){
    for (i=1;i<=counts;i++)
    {
        g(tabname+'tab0'+i).className=tabclass+' ';
    }
    g(tabname+'tab0'+num).className=tabclass+'act' ;
}