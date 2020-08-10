/**
* Copyright © 1998-2019, Glodon Inc. All Rights Reserved.
*/
package com.bizwink.util;

import java.nio.charset.Charset;

import com.bizwink.cms.server.MyConstants;

import org.apache.commons.codec.binary.Base64;

/**
 * DES加密工具
 * 
 * @author fucy
 * @since jdk1.6
 * 2019年6月10日
 */
public class Des {
	private static final Charset UTF8 = Charset.forName("UTF-8");

	/**
	 * DES解密
	 * 
	 * @param content
	 * @param key 长度至少8位
	 * @return
	 */
	public static String decrypt(String content, String key){
		byte[] result = DESUtil.decrypt(Base64.decodeBase64(content), Base64.encodeBase64String(key.getBytes(UTF8)));
		
		return new String(result, UTF8);
	}
	
	/**
	 * DES加密
	 * 
	 * @param content
	 * @param key 长度至少8位
	 * @return
	 */
	public static String encrypt(String content, String key){
		byte[] result = DESUtil.encrypt(content.getBytes(UTF8), Base64.encodeBase64String(key.getBytes(UTF8)));
		
		return Base64.encodeBase64String(result);
	}

	public static void main(String[] args) {
		String retval = Des.decrypt("kH9Axan7AA7pFP+TZLiZTHFrtnqw9j+pDgxcWcBSytkL6ushWoNGI1tcUjx67wUrqhvRosxO7Es1AtPYQ8AorBCVWqYfPiuU/U0DkFEbWHU=", MyConstants.getSecret_key());
	    System.out.println(retval);
	}

}
