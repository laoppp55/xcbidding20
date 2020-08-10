package com.unittest;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

public class dxinterface {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		dxinterface test = new dxinterface();
		//test.sendSignInfo();
		test.sendEnrollInfo();
	}

	public void sendSignInfo() {
		// TODO 自动生成的方法存根
		dxinterface test = new dxinterface();
		String url = "http://i.bucg.com:80/service/XChangeServlet?account=0001&groupcode=0001";

		String strxml = "<?xml version=\"1.0\" encoding='UTF-8'?>" +
				"<ufinterface account=\"0001\" billtype=\"HM26\" filename=\"\" groupcode=\"0001\" isexchange=\"Y\" replace=\"Y\" roottag=\"\" sender=\"cjpxmng\">" +
				"    <bill id=\"\">" +
				"        <billhead>" +
				"            <pk_group>0001</pk_group>" +
				"            <dbilldate>2019-10-30 09:31:28</dbilldate>" +
				"            <vbillstatus>0</vbillstatus>" +
				"            <pk_billtype>HM26</pk_billtype>" +
				"            <creator>zhanghao</creator>" +
				"            <creationtime>2019-10-30 09:31:28</creationtime>" +
				"            <pk_tranpro>HM132019121100000001</pk_tranpro>" +
				"            <pk_classset_b>1001</pk_classset_b>" +
				"            <pk_workunit>云合</pk_workunit>" +
				"            <pk_tranpsn>张三</pk_tranpsn>" +
				"            <cardid>110105196609308153</cardid>" +
				"            <dcheckindate>2019-12-11 09:31:28</dcheckindate>" +
				"            <checkinam>Y</checkinam>" +
				"            <checkinpm>N</checkinpm>" +
				"            <memo>备注</memo>" +
				"            <def1>add</def1>" +
				"            <def2>MH20191030</def2>" +
				"        </billhead>" +
				"    </bill>" +
				"</ufinterface>";

		String returnxml = test.ArapXML(url, strxml);
		System.out.println(returnxml);
	}

	public void sendEnrollInfo() {
		String url = "http://i.bucg.com:80/service/XChangeServlet?account=0001&groupcode=0001";
		dxinterface test = new dxinterface();

		String strxml = "<?xml version=\"1.0\" encoding='UTF-8'?>" +
				"<ufinterface account=\"0001\" billtype=\"HM24\" filename=\"\" groupcode=\"0001\" isexchange=\"Y\" replace=\"Y\" roottag=\"\" sender=\"cjpxmng\">" +
				"    <bill id=\"MH20191030\">" +
				"        <billhead>" +
				"            <pk_group>0001</pk_group>" +
				"            <pk_billtype>HM24</pk_billtype>" +
				"            <dbilldate>2019-10-28 09:00:26</dbilldate>" +
				"            <vbillstatus>-1</vbillstatus>" +
				"            <creator>zhanghao</creator>" +
				"            <creationtime>2019-10-30 09:31:28</creationtime>" +
				"            <pk_tranpro>HM132019121100000001</pk_tranpro>" +
				"            <pk_sepecial>1001</pk_sepecial>" +
				"            <sigtype>1</sigtype>" +
				"            <stuname>张三</stuname>" +
				"            <stucardid>110105196609308153</stucardid>" +
				"            <stusex>1</stusex>" +
				"            <stunation>汉族</stunation>" +
				"            <dstubirthday>2019-10-28 09:00:26</dstubirthday>" +
				"            <polstatus>a</polstatus>" +
				"            <stuedu>a</stuedu>" +
				"            <jobtitle>a</jobtitle>" +
				"            <curpost>a</curpost>" +
				"            <telphone>a</telphone>" +
				"            <wbunit>城建勘测院</wbunit>" +
				"            <ntotalfee>1000</ntotalfee>" +
				"            <def1>del</def1>" +
				"            <def2>MH20191030</def2>" +
				"            <bodymx>" +
				"                <item>" +
				"                    <pk_classs>1001</pk_classs>" +
				"                    <classname>测试课程</classname>" +
				"                    <dclasshour>1</dclasshour>" +
				"                    <dclassfee>1000</dclassfee>" +
				"                </item>" +
				"            </bodymx>" +
				"        </billhead>" +
				"    </bill>" +
				"</ufinterface>";

		String returnxml = test.ArapXML(url, strxml);
		System.out.println(returnxml);
	}

	public String ArapXML(String url, String strxml) {
		OutputStreamWriter wr = null;
		BufferedReader rd = null;
		String msg = "";
		try {
			URLConnection conn = getUrlConnection(url, "v6");
			wr = new OutputStreamWriter(conn.getOutputStream(),"UTF-8");

			wr.write(strxml);
			wr.flush();

			rd = new BufferedReader(new InputStreamReader(
					conn.getInputStream(), "UTF-8"));
			String line;
			StringBuffer response = new StringBuffer("");
			while ((line = rd.readLine()) != null) {
				response.append(line);
				response.append(System.getProperty("line.separator"));
			}
			if (response.length() == 0) {
				throw new Exception("未接收到返回数据!");
			}
			msg = response.toString();


		} catch (Exception e) {

			e.printStackTrace();
		}
		return msg;

	}

	private  URLConnection getUrlConnection(String oppurl, String ncVersion) throws Exception {

		if (ncVersion.startsWith("v6")) {
			return getConnection4v5(oppurl);
		}
		throw new Exception("链接失败!");
	}
	private HttpURLConnection getConnection4v5(String url) throws Exception {
		try {
			URL realURL = new URL(url);
			HttpURLConnection connection = (HttpURLConnection) realURL
					.openConnection();
			connection.setDoOutput(true);
			connection.setRequestProperty("Content-type", "text/xml");
			connection.setRequestMethod("POST");
			return connection;
		} catch (IOException ex) {
			ex.printStackTrace();
			throw new Exception("错误:" + ex.getMessage());
		}
	}

}
