<%@page contentType="text/html;charset=GBK" %>
<%@page import="com.yeepay.PaymentForOnlineService,com.yeepay.Configuration"%>
<%@ page import="com.bizwink.util.SpringInit" %>
<%@ page import="org.springframework.context.ApplicationContext" %>
<%@ page import="com.bizwink.mysql.service.MEcService" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%!	String formatString(String text){
			if(text == null) {
				return ""; 
			}
			return text;
		}
%>
<%
	String keyValue   = formatString(Configuration.getInstance().getValue("keyValue"));                            // �̼���Կ
	String r0_Cmd 	  = formatString(request.getParameter("r0_Cmd"));                                              // ҵ������
	String p1_MerId   = formatString(Configuration.getInstance().getValue("p1_MerId"));                            // �̻����
	String r1_Code    = formatString(request.getParameter("r1_Code"));                                             // ֧�����
	String r2_TrxId   = formatString(request.getParameter("r2_TrxId"));                                            // �ױ�֧��������ˮ��
	String r3_Amt     = formatString(request.getParameter("r3_Amt"));                                              // ֧�����
	String r4_Cur     = formatString(request.getParameter("r4_Cur"));                                              // ���ױ���
	String r5_Pid     = new String(formatString(request.getParameter("r5_Pid")).getBytes("iso-8859-1"),"gbk");  // ��Ʒ����
	String r6_Order   = formatString(request.getParameter("r6_Order"));                                            // �̻�������
	String r7_Uid     = formatString(request.getParameter("r7_Uid"));                                              // �ױ�֧����ԱID
	String r8_MP      = new String(formatString(request.getParameter("r8_MP")).getBytes("iso-8859-1"),"gbk");   // �̻���չ��Ϣ
	String r9_BType   = formatString(request.getParameter("r9_BType"));                                            // ���׽����������,1������ض��� 2��������Ե�
	String hmac       = formatString(request.getParameter("hmac"));                                                // ǩ������
    String rp_PayDate = formatString(request.getParameter("rp_PayDate"));                                         //֧���ɹ�ʱ��
    String ru_Trxtime = formatString(request.getParameter("ru_Trxtime"));                                         //֧��״̬֪ͨʱ��

    boolean isOK = false;
	// У�鷵�����ݰ�
	isOK = PaymentForOnlineService.verifyCallback(hmac,p1_MerId,r0_Cmd,r1_Code,r2_TrxId,r3_Amt,r4_Cur,r5_Pid,r6_Order,r7_Uid,r8_MP,r9_BType,keyValue);
	if(isOK) {
		//�ڽ��յ�֧�����֪ͨ���ж��Ƿ���й�ҵ���߼�������Ҫ�ظ�����ҵ���߼�����
        ApplicationContext appContext = SpringInit.getApplicationContext();
        MEcService mEcService = null;
        if(r1_Code.equals("1")) {
            long orderid = Long.parseLong(r6_Order);
            if (appContext!=null)
                mEcService = (MEcService)appContext.getBean("MEcService");
            else {
                response.sendRedirect("/error.jsp?errcode=-1");
                return;
            }
			// ��Ʒͨ�ýӿ�֧���ɹ�����-������ض���
            SimpleDateFormat format=new SimpleDateFormat("yyyyMMddhhmmss");
			if(r9_BType.equals("1")) {
                //UpdatePayflag(long orderid,String jylsh,String zfmemberid,int r2type,String payresult,int payflag)
                //����1��������
                //����2��������֧������Ľ�����ˮ��
                //����3��֧���̻���
                //����4��֧����������
                //����5��֧��������
                //����6��1��ʾ�Ѿ����֧��
                //����7�������ǵ�����֧����ţ�0--΢��  2--���� 1-֧����
                Date pay_sucess_date = format.parse(rp_PayDate);
                mEcService.UpdatePayflag(orderid,r2_TrxId,r7_Uid,r9_BType,r1_Code,1,2,new Timestamp(pay_sucess_date.getTime()));
                out.println("<script   lanugage=\"javascript\">alert(\"֧���ɹ���\");window.close();</script>");
				//out.println("callback��ʽ:��Ʒͨ�ýӿ�֧���ɹ�����-������ض���");
				// ��Ʒͨ�ýӿ�֧���ɹ�����-��������Ե�ͨѶ
			} else if(r9_BType.equals("2")) {
				// ����ڷ���������ʱ	����ʹ��Ӧ�����ʱ������Ӧ����"success"��ͷ���ַ�������Сд������
                //orderMgr.updateStatus(id,4,"");
                //����1��������
                //����2��������֧������Ľ�����ˮ��
                //����3��֧���̻���
                //����4��֧����������
                //����5��֧��������
                //����6��1��ʾ�Ѿ����֧��
                //����7�������ǵ�����֧����ţ�0--΢��  2--���� 1-֧����
                Date pay_sucess_date = format.parse(rp_PayDate);
                mEcService.UpdatePayflag(orderid,r2_TrxId,r7_Uid,r9_BType,r1_Code,1,2,new Timestamp(pay_sucess_date.getTime()));
				out.println("SUCCESS");
			  // ��Ʒͨ�ýӿ�֧���ɹ�����-�绰֧������		
			}
			// ����ҳ������ǲ���ʱ�۲���ʹ��
			//out.println("<br>���׳ɹ�!<br>�̼Ҷ�����:" + r6_Order + "<br>֧�����:" + r3_Amt + "<br>�ױ�֧��������ˮ��:" + r2_TrxId);
		}
	} else {
		out.println("����ǩ�����۸�!");
	}
%>