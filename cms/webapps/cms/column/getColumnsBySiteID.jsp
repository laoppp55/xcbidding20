<%@ page import="com.bizwink.cms.util.SessionUtil" %>
<%@ page import="com.bizwink.cms.security.Auth" %>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.service.ColumnService" %>
<%@ page import="com.bizwink.po.Column" %>
<%@ page import="java.util.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.bizwink.cms.news.ColumnVO" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="com.bizwink.cms.util.FileUtil" %>
<%@ page import="com.bizwink.cms.util.ParamUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 18-5-24
  Time: 下午9:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Auth authToken = SessionUtil.getUserAuthorization(request, response, session);
    if (authToken == null)
    {
        response.sendRedirect(response.encodeRedirectURL("/webbuilder/index.jsp?msg=系统超时，请重新登陆!"));
        return;
    }

    response.setHeader("Pragma","No-cache");
    response.setHeader("Cache-Control","no-cache");
    response.setDateHeader("Expires", 0);
    int columnid = ParamUtil.getIntParameter(request,"column",0);

    int siteid = authToken.getSiteID();
    ApplicationContext appContext = SpringInit.getApplicationContext();
    List<Column> columns = new ArrayList<Column>();
    List<ColumnVO> columnVOs = null;
    Column rootColumn = null;
    if (appContext!=null) {
        ColumnService columnService = (ColumnService)appContext.getBean("columnService");
        rootColumn = columnService.getRootColumnBySiteid(BigDecimal.valueOf(siteid));
        columns = columnService.getSubColumns(BigDecimal.valueOf(columnid),BigDecimal.valueOf(siteid));
        columnVOs = new ArrayList<ColumnVO>();
        for(int ii=0;ii<columns.size();ii++) {
            Column column = columns.get(ii);
            int subcolumncount = columnService.getSubColumnsCount(column.getID()).intValue();
            ColumnVO columnVO = new ColumnVO();
            columnVO.setID(column.getID().intValue());
            columnVO.setParentID(column.getPARENTID().intValue());
            columnVO.setSiteid(column.getSITEID().intValue());
            columnVO.setOrderID(column.getORDERID().intValue());
            columnVO.setDirName(column.getDIRNAME());
            columnVO.setDefineAttr(column.getISDEFINEATTR());
            columnVO.setHasArticleModel(column.getHASARTICLEMODEL());
            columnVO.setCName(column.getCNAME());
            columnVO.setEName(column.getENAME());
            columnVO.setExtname(column.getEXTNAME());
            columnVO.setCreateDate(column.getCREATEDATE());
            columnVO.setLastUpdated(column.getLASTUPDATED());
            columnVO.setIsAudited(column.getISAUDITED());
            if (subcolumncount>0) {
                columnVO.setLeaf(false);
            } else{
                columnVO.setLeaf(true);
            }
            if (column.getID().intValue()!=rootColumn.getID().intValue()) columnVOs.add(columnVO);
        }
    }

    if (columnVOs != null) {
        SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String jsondata = "";
        if (columnid == rootColumn.getID().intValue()) {     //点击首页节点扩展栏目树
            jsondata = "{\"total\":" + (columnVOs.size() + 1) + ",\"rows\":[\r\n";
            if (columnVOs.size() == 0)    //表示树表只有一行数据
                jsondata = jsondata + "{\"ID\":" + rootColumn.getID() + ",\"CNAME\":\"" + rootColumn.getCNAME() + "\",\"DIRNAME\":\"" + rootColumn.getDIRNAME() + "\",\"ORDERID\":" + rootColumn.getORDERID() + ",\"CREATEDATE\":\"" + dateformat.format(rootColumn.getCREATEDATE()) + "\"}\r\n";
            else                          //表示树表有多行数据
                jsondata = jsondata + "{\"ID\":" + rootColumn.getID() + ",\"CNAME\":\"" + rootColumn.getCNAME() + "\",\"DIRNAME\":\"" + rootColumn.getDIRNAME() + "\",\"ORDERID\":" + rootColumn.getORDERID() + ",\"CREATEDATE\":\"" + dateformat.format(rootColumn.getCREATEDATE()) + "\"},\r\n";
        }  else {                                           //点击某个节点扩展栏目树
            jsondata = "{\"total\":" + (columnVOs.size()) + ",\"rows\":[\r\n";
        }
        for (int ii = 0; ii < columnVOs.size(); ii++) {
            ColumnVO columnVO = columnVOs.get(ii);
            int pid = columnVO.getParentID();
            String cname = columnVO.getCName();
            if (ii < columnVOs.size() - 1) {
                if (pid > 0) {
                    if (!columnVO.isLeaf())
                        jsondata = jsondata + "{\"ID\":" + columnVO.getID() + ",\"_parentId\":" + pid + ",\"CNAME\":\"" + cname + "\",\"DIRNAME\":\"" + columnVO.getDirName() + "\",\"ORDERID\":" + columnVO.getOrderID() + ",\"CREATEDATE\":\"" + dateformat.format(columnVO.getCreateDate()) + "\",\"state\":\"closed\"},\r\n";
                    else
                        jsondata = jsondata + "{\"ID\":" + columnVO.getID() + ",\"_parentId\":" + pid + ",\"CNAME\":\"" + cname + "\",\"DIRNAME\":\"" + columnVO.getDirName() + "\",\"ORDERID\":" + columnVO.getOrderID() + ",\"CREATEDATE\":\"" + dateformat.format(columnVO.getCreateDate()) + "\"},\r\n";
                } else {
                    if (!columnVO.isLeaf())
                        jsondata = jsondata + "{\"ID\":" + columnVO.getID() + ",\"CNAME\":\"" + cname + "\",\"DIRNAME\":\"" + columnVO.getDirName() + "\",\"ORDERID\":" + columnVO.getOrderID() + ",\"CREATEDATE\":\"" + dateformat.format(columnVO.getCreateDate()) + "\",\"state\":\"closed\"},\r\n";
                    else
                        jsondata = jsondata + "{\"ID\":" + columnVO.getID() + ",\"CNAME\":\"" + cname + "\",\"DIRNAME\":\"" + columnVO.getDirName() + "\",\"ORDERID\":" + columnVO.getOrderID() + "},\r\n";
                }
            } else {
                if (pid > 0) {
                    if (!columnVO.isLeaf())
                        jsondata = jsondata + "{\"ID\":" + columnVO.getID() + ",\"_parentId\":" + pid + ",\"CNAME\":\"" + cname + "\",\"DIRNAME\":\"" + columnVO.getDirName() + "\",\"ORDERID\":" + columnVO.getOrderID() + ",\"CREATEDATE\":\"" + dateformat.format(columnVO.getCreateDate()) + "\",\"state\":\"closed\"}\r\n";
                    else
                        jsondata = jsondata + "{\"ID\":" + columnVO.getID() + ",\"_parentId\":" + pid + ",\"CNAME\":\"" + cname + "\",\"DIRNAME\":\"" + columnVO.getDirName() + "\",\"ORDERID\":" + columnVO.getOrderID() + ",\"CREATEDATE\":\"" + dateformat.format(columnVO.getCreateDate()) + "\"}\r\n";
                } else {
                    if (!columnVO.isLeaf())
                        jsondata = jsondata + "{\"ID\":" + columnVO.getID() + ",\"CNAME\":\"" + cname + "\",\"DIRNAME\":\"" + columnVO.getDirName() + "\",\"ORDERID\":" + columnVO.getOrderID() + ",\"CREATEDATE\":\"" + dateformat.format(columnVO.getCreateDate()) + "\",\"state\":\"closed\"}\r\n";
                    else
                        jsondata = jsondata + "{\"ID\":" + columnVO.getID() + ",\"CNAME\":\"" + cname + "\",\"DIRNAME\":\"" + columnVO.getDirName() + "\",\"ORDERID\":" + columnVO.getOrderID() + ",\"CREATEDATE\":\"" + dateformat.format(columnVO.getCreateDate()) + "\"}\r\n";
                }
            }
        }
        jsondata = jsondata +"]}";
        //FileUtil.writeFile(new StringBuffer(jsondata),"c:\\data\\1122.txt");
        //System.out.println(jsondata);
        out.print(jsondata);
        out.flush();
    } else {
        System.out.println("error");
        out.print("nodata");
        out.flush();
    }
    return;
%>