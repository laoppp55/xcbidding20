package com.alipay.util;

import com.alipay.util.Md5Encrypt;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.io.UnsupportedEncodingException;

public class SignatureHelper_return {
	public static String sign(Map params, String privateKey) {
		Properties properties = new Properties();

		for (Iterator iter = params.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			Object value = params.get(name);
			//if (value == null) {
			//	continue;
			//}

			if (name == null || name.equalsIgnoreCase("sign")
					|| name.equalsIgnoreCase("sign_type")) {
				continue;
			}

			properties.setProperty(name, value.toString());
		}

		String content = getSignatureContent(properties);
		return sign(content, privateKey);
	}

	
	public static String getSignatureContent(Properties properties) {
		StringBuffer content = new StringBuffer();
		List keys = new ArrayList(properties.keySet());
		Collections.sort(keys);

		for (int i = 0; i < keys.size(); i++) {
			String key = (String) keys.get(i);
			String value = properties.getProperty(key);
			try{
			 value=new String(value.getBytes("ISO-8859-1"),"GB2312");
			}
			catch (UnsupportedEncodingException e){}
		
			content.append((i == 0 ? "" : "&") + key + "=" + value);
		}

		return content.toString();
	}

	public static String sign(String content, String privateKey) {
		if (privateKey == null) {
			return null;
		}
		String signBefore = content + privateKey;
		System.out.print("signBefore="+signBefore);
		return Md5Encrypt.md5(signBefore);

	}

}
