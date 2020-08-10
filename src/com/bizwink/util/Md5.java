/**
 * 
 */
package com.bizwink.util;
import java.security.MessageDigest;

/**
 * @author lysming
 * 
 */

public class Md5 {

	/**
	 * md5加密方法
	 * 
	 * @author: lysming
	 * @param plainText
	 *            加密字符串
	 * @return String 返回32位md5加密字符串16位加密取substring(8,24))
	 */
	public final static String md5(String plainText) {

		// 返回字符串
		String md5Str = null;
		try {
			// 操作字符串
			StringBuffer buf = new StringBuffer();

			/**
			 * MessageDigest 类为应用程序提供信息摘要算法的功能，�?MD5 �?SHA 算法�?
			 * 信息摘要是安全的单向哈希函数，它接收任意大小的数据，并输出固定长度的哈希值�?
			 * 
			 * MessageDigest 对象�?��被初始化�?该对象�?过使�?update()方法处理数据�?任何时�?都可以调�?
			 * reset()方法重置摘要�?�?���?���?��更新的数据都已经被更新了，应该调用digest()方法之一完成哈希计算�?
			 * 
			 * 对于给定数量的更新数据，digest 方法只能被调用一次�? 在调�?digest 之后，MessageDigest
			 * 对象被重新设置成其初始状态�?
			 */
			MessageDigest md = MessageDigest.getInstance("MD5");

			// 添加要进行计算摘要的信息,使用 plainText �?byte 数组更新摘要�?
			md.update(plainText.getBytes("UTF-8"));

			// 计算出摘�?完成哈希计算�?
			byte b[] = md.digest();
			int i;

			for (int offset = 0; offset < b.length; offset++) {

				i = b[offset];

				if (i < 0) {
					i += 256;
				}

				if (i < 16) {
					buf.append("0");
				}

				// 将整�?十进�?i 转换�?6位，用十六进制参数表示的无符号整数�?的字符串表示形式�?
				buf.append(Integer.toHexString(i));

			}

			// 32位的加密
			md5Str = buf.toString();

			// 16位的加密
			// md5Str = buf.toString().md5Strstring(8,24);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return md5Str;
	}
	
}