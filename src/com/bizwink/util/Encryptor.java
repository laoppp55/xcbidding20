/**
 * Copyright By Grandsoft Company Limited.  
 * 2014年3月26日 下午4:11:51
 */
package com.bizwink.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.security.Key;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;

/**
 * 对数据进行加密、解密操作的基础工具类
 * <p>
 * <b>创建日期</b> 2014年3月26日
 * </p>
 * @author <a href="mailto:hemw@grandsoft.com.cn">何明旺</a>
 * @since 3.0
 */
public class Encryptor {

    /** The MD2 message digest algorithm defined in RFC 1319. */
    public static final String MD2 = "MD2";

    /** The MD5 message digest algorithm defined in RFC 1321. */
    public static final String MD5 = "MD5";
    
    /** Secure Hash Algorithm，安全散列算法 */
    public static final String SHA = "SHA";

    /** The SHA-1 hash algorithm defined in the FIPS PUB 180-2. */
    public static final String SHA_1 = "SHA-1";

    /** The SHA-256 hash algorithm defined in the FIPS PUB 180-2. */
    public static final String SHA_256 = "SHA-256";

    /** The SHA-384 hash algorithm defined in the FIPS PUB 180-2. */
    public static final String SHA_384 = "SHA-384";

    /** The SHA-512 hash algorithm defined in the FIPS PUB 180-2. */
    public static final String SHA_512 = "SHA-512";

    /**
     * 获取 MessageDigest 实例
     * @param algorithm 加密算法，请参见本类中的名称为 {@code MD*} 和 {@code SHA*} 的常量
     * @return MessageDigest 实例
     */
    public static MessageDigest getMessageDigest(String algorithm){
        try {
            return MessageDigest.getInstance(algorithm);
        } catch (NoSuchAlgorithmException e) {
            //throw new GboatSecurityException("算法 [" + algorithm + "] 不存在，或当前  JDK 不支持该算法。", e);
        }

        return null;
    }

    /**
     * 
     * @param data 要加密的数据
     * @param algorithm 加密算法，请参见本类中的名称为 {@code MD*} 和 {@code SHA*} 的常量
     * @return 密文
     */
    public static byte[] digest(byte[] data, String algorithm){
        if(data == null) {
            return null;
        }
        
        MessageDigest messageDigest = getMessageDigest(algorithm);
        messageDigest.update(data);
        return messageDigest.digest(); 
    }
    
    /**
     * @param data 要加密的字符串
     * @param algorithm 加密算法，请参见本类中的名称为 {@code MD*} 和 {@code SHA*} 的常量
     * @return 密文
     */
    public static byte[] digest(String data, String algorithm){
        try {
			return (data == null) ? null : digest(data.getBytes("UTF-8"), algorithm);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return null;
    }
    
    /**
     * @param file  要加密的文件
     * @param algorithm 加密算法，请参见本类中的名称为 {@code MD*} 和 {@code SHA*} 的常量
     * @return 密文
     */
    public static byte[] digest(File file, String algorithm){
        if(file == null) {
            return null;
        }
        
        MessageDigest messageDigest = getMessageDigest(algorithm);
        InputStream input = null;
        try {
            input = new FileInputStream(file);
            byte[] buffer = new byte[4096];
            int length = 0;
            while ((length = input.read(buffer)) > 0) {
                messageDigest.update(buffer, 0, length);
            }
        } catch (FileNotFoundException e) {
            //throw new GboatSecurityException("文件 [" + file.getAbsolutePath() + "] 不存在。", e);
        } catch (IOException e) {
            //throw new GboatSecurityException("读取文件 [" + file.getAbsolutePath() + "] 发生错误。", e);
        } finally {
            IOUtils.closeQuietly(input);
        }
        return messageDigest.digest();
    }
    
    /**
     * 获取密钥生成器实例
     * 
     * @param algorithm 加密算法的名称，支持的算法有：
     *            AES、ARCFOUR、Blowfish、DES、DESede、HmacMD5、HmacSHA1、HmacSHA256、HmacSHA384、HmacSHA512、RC2
     * @return 密钥生成器
     */
    public static KeyGenerator getKeyGenerator(String algorithm) {
        try {
            return KeyGenerator.getInstance(algorithm);
        } catch (NoSuchAlgorithmException e) {
            //throw new GboatSecurityException("获取密钥生成器实例失败：算法 [" + algorithm + "] 不存在，或当前  JDK 不支持该算法。", e);
        }
        return null;
    }
    
    /**
     * 根据算法名称和密钥长度生成私钥公钥对
     * @param algorithm 算法名称，如：RSA、DSA
     * @param size 密钥长度，如：512、1024
     * @return 私钥公钥对
     */
    public static KeyPair getKeyPair(String algorithm, int size) {
        try {
            KeyPairGenerator keyGen = KeyPairGenerator.getInstance(algorithm);
            keyGen.initialize(size);
            return keyGen.genKeyPair();
        } catch (NoSuchAlgorithmException e) {
            //throw new GboatSecurityException("生成私钥公钥对失败：算法 [" + algorithm + "] 不存在，或当前  JDK 不支持该算法。", e);
            return null;
        }
    }
    
    /**
     * 取得算法名称
     * @param transformation 算法模型 
     * @return 算法名称
     */
    protected static String getAlgorithmFromTransformation(String transformation) {
        return StringUtils.substringBefore(transformation, "/");
    }
    

    /**
     * 对数据进行加密
     * 
     * @param data 要加密的明文数据
     * @param key 密钥
     * @param transformation the name of the transformation, format is "Algorithm/Modes/Paddings", e.g.,
     *            DES/CBC/PKCS5Padding. See Appendix A in the <a target="_blank"
     *            href="http://docs.oracle.com/javase/6/docs/technotes/guides/security/crypto/CryptoSpec.html#AppA">
     *            Java Cryptography Architecture Reference Guide</a> for information about standard transformation names.<br>
     *            <table>
     *            <caption><h3>The following table lists cipher algorithms available in the SunJCE provider</h3></caption>
     *            <thead>
     *            <tr>
     *            <th>Algorithm Name</th>
     *            <th>Modes</th>
     *            <th>Paddings</th>
     *            </tr>
     *            </thead>
     *            <tbody>
     *            <tr>
     *            <td>AES</td>
     *            <td>ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB128, OFB,
     *            OFB8..OFB128</td>
     *            <td>NOPADDING, PKCS5PADDING, ISO10126PADDING</td>
     *            </tr>
     *            <tr>
     *            <td>AESWrap</td>
     *            <td>ECB</td>
     *            <td>NOPADDING</td>
     *            </tr>
     *            <tr>
     *            <td>ARCFOUR</td>
     *            <td>ECB</td>
     *            <td>NOPADDING</td>
     *            </tr>
     *            <tr>
     *            <td>Blowfish, DES, DESede, RC2</td>
     *            <td>ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB,
     *            OFB8..OFB64</td>
     *            <td>NOPADDING, PKCS5PADDING, ISO10126PADDING</td>
     *            </tr>
     *            <tr>
     *            <td>DESedeWrap</td>
     *            <td>CBC</td>
     *            <td>NOPADDING</td>
     *            </tr>
     *            <tr>
     *            <td>PBEWithMD5AndDES, PBEWithMD5AndTripleDES,
     *            PBEWithSHA1AndDESede, PBEWithSHA1AndRC2_40</td>
     *            <td>CBC</td>
     *            <td>PKCS5Padding</td>
     *            </tr>
     *            <tr>
     *            <td>RSA</td>
     *            <td>ECB</td>
     *            <td>NOPADDING, PKCS1PADDING, OAEPWITHMD5ANDMGF1PADDING,
     *            OAEPWITHSHA1ANDMGF1PADDING, OAEPWITHSHA-1ANDMGF1PADDING,
     *            OAEPWITHSHA-256ANDMGF1PADDING, OAEPWITHSHA-384ANDMGF1PADDING,
     *            OAEPWITHSHA-512ANDMGF1PADDING <!-- OAEPPadding later --></td>
     *            </tr>
     *            </tbody>
     *            </table>
     * @return 密文
     */
    public static byte[] encrypt(byte[] data, Key key, String transformation) {  
        try {
            Cipher cipher = Cipher.getInstance(transformation);  
            cipher.init(Cipher.ENCRYPT_MODE, key);  
            return cipher.doFinal(data);
        } catch (Exception e) {
            throw new IllegalArgumentException("对数据进行 [" + transformation + "] 加密失败。", e);
        }  
    }

    /**
     * 对数据进行解密
     * 
     * @param data 要解密的明文数据
     * @param key 密钥
     * @param transformation the name of the transformation, format is "Algorithm/Modes/Paddings", e.g.,
     *            DES/CBC/PKCS5Padding. See Appendix A in the <a target="_blank"
     *            href="http://docs.oracle.com/javase/6/docs/technotes/guides/security/crypto/CryptoSpec.html#AppA">
     *            Java Cryptography Architecture Reference Guide</a> for information about standard transformation names.<br>
     *            <table>
     *            <caption><h3>The following table lists cipher algorithms available in the SunJCE provider</h3></caption>
     *            <thead>
     *            <tr>
     *            <th>Algorithm Name</th>
     *            <th>Modes</th>
     *            <th>Paddings</th>
     *            </tr>
     *            </thead>
     *            <tbody>
     *            <tr>
     *            <td>AES</td>
     *            <td>ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB128, OFB,
     *            OFB8..OFB128</td>
     *            <td>NOPADDING, PKCS5PADDING, ISO10126PADDING</td>
     *            </tr>
     *            <tr>
     *            <td>AESWrap</td>
     *            <td>ECB</td>
     *            <td>NOPADDING</td>
     *            </tr>
     *            <tr>
     *            <td>ARCFOUR</td>
     *            <td>ECB</td>
     *            <td>NOPADDING</td>
     *            </tr>
     *            <tr>
     *            <td>Blowfish, DES, DESede, RC2</td>
     *            <td>ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB,
     *            OFB8..OFB64</td>
     *            <td>NOPADDING, PKCS5PADDING, ISO10126PADDING</td>
     *            </tr>
     *            <tr>
     *            <td>DESedeWrap</td>
     *            <td>CBC</td>
     *            <td>NOPADDING</td>
     *            </tr>
     *            <tr>
     *            <td>PBEWithMD5AndDES, PBEWithMD5AndTripleDES,
     *            PBEWithSHA1AndDESede, PBEWithSHA1AndRC2_40</td>
     *            <td>CBC</td>
     *            <td>PKCS5Padding</td>
     *            </tr>
     *            <tr>
     *            <td>RSA</td>
     *            <td>ECB</td>
     *            <td>NOPADDING, PKCS1PADDING, OAEPWITHMD5ANDMGF1PADDING,
     *            OAEPWITHSHA1ANDMGF1PADDING, OAEPWITHSHA-1ANDMGF1PADDING,
     *            OAEPWITHSHA-256ANDMGF1PADDING, OAEPWITHSHA-384ANDMGF1PADDING,
     *            OAEPWITHSHA-512ANDMGF1PADDING <!-- OAEPPadding later --></td>
     *            </tr>
     *            </tbody>
     *            </table>
     * 
     * @return 密文
     */
    public static byte[] decrypt(byte[] data, Key key, String transformation) {  
        try {
            Cipher cipher = Cipher.getInstance(transformation);  
            cipher.init(Cipher.DECRYPT_MODE, key);  
            return cipher.doFinal(data);
        } catch (Exception e) {
            throw new IllegalArgumentException("对数据进行 [" + transformation + "] 解密失败。", e);
        }  
    }
    
}
