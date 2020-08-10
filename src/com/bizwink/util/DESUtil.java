/**
 * Copyright By Grandsoft Company Limited.  
 * 2014年3月18日 上午10:31:11
 */
package com.bizwink.util;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Arrays;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;
/**
 * DES 加密、解密工具类，支持 DES、DESede(TripleDES,就是3DES)、AES、Blowfish、RC2、RC4(ARCFOUR)
 * 等加密算法。
 * <pre>
 * DES                  key size must be equal to 56 
 * DESede(TripleDES)    key size must be equal to 112 or 168 
 * AES                  key size must be equal to 128, 192 or 256,but 192 and 256 bits may not be available 
 * Blowfish             key size must be multiple of 8, and can only range from 32 to 448 (inclusive) 
 * RC2                  key size must be between 40 and 1024 bits 
 * RC4(ARCFOUR)         key size must be between 40 and 1024 bits
 * 
 * 
 * Java 和 .NET 程序进行 3DES 加解密数据交互的示例：
 * <code>
 * String data = "hemw, 你好！";
 * String key = "F8-DC-2F-AA-C8-A6-82-E3-EB-35-2A-E2-DC-EA-38-FD";
 * 
 * System.out.println("加密前：" + data);
 * System.out.println("  密钥：" + key);
 * 
 * Key k = DESUtil.getSecretKey(key, DESUtil.DESEDE, true);
 * String encryptedText = DESUtil.encrypt(data, k, DESUtil.DESEDE_WITH_DOTNET);
 * System.out.println("加密后：" + encryptedText); // .NET 可以直接对该密文进行解密
 * 
 * // encryptedText 为 .NET 加密后的密文
 * String decryptedText = DESUtil.decrypt(encryptedText, k, DESUtil.DESEDE_WITH_DOTNET);
 * System.out.println("解密后：" + decryptedText);
 * </code>
 * </pre>
 * 在使用该工具类进行加密、解密操作时，一定要注意不同加密算法对密钥的长度要求。更多内容请参考
 * <a href="http://docs.oracle.com/javase/7/docs/technotes/guides/security/SunProviders.html" target ="_blank">
 * http://docs.oracle.com/javase/7/docs/technotes/guides/security/SunProviders.html
 * </a>
 * <p>
 * <b>创建日期</b> 2014年3月18日
 * </p>
 * 
 * @author <a href="mailto:hemw@grandsoft.com.cn">何明旺</a>
 * @since 3.0
 */
public class DESUtil {

    /** key size must be equal to 56, default key size is 56 bits */
    public static final String DES = "DES";
    
    /**
     * (TripleDES) key size must be equal to 112 or 168, default key size is 168 bits<br>
     * A keysize of 112 will generate a Triple DES key with 2 intermediate keys,
     * and a keysize of 168 will generate a Triple DES key with 3 intermediate
     * keys.<br>
     * Due to the "Meet-In-The-Middle" problem, even though 112 or 168 bits of
     * key material are used, the effective keysize is 80 or 112 bits
     * respectively.
     */
    public static final String DESEDE = "DESede";
    
    /** key size must be equal to 128, 192 or 256,but 192 and 256 bits, may not be available, default key size is 128 bits */
    public static final String AES = "AES";
    
    /** key size must be multiple of 8, and can only range from 32 to 448 (inclusive), default key size is 128 bits */
    public static final String BLOWFISH = "Blowfish";

    /** key size must be between 40 and 1024 bits (inclusive), default key size is 128 bits */
    public static final String RC2 = "RC2";
    
    /** (ARCFOUR)   Keysize must range between 40 and 1024 bits (inclusive), default key size is 128 bits */
    public static final String RC4 = "RC4";
    
    /** .NET 默认的 3DES 加密的算法模型，值为 {@value} */
    public static final String DESEDE_WITH_DOTNET = "DESede/ECB/PKCS5Padding";
    
    /** 默认密钥 */
    private static final String DEFAULT_KEY = "com.glodon.default4gbp";

    /**
     * 生成 DES 密钥
     * 
     * @return 生成的随机密钥
     */
    public static String generateKey() {
        return generateKey(null);
    }

    /**
     * 生成 DES 密钥
     * 
     * @param seed 种子
     * @return 经过 BASE64 编码的密钥字符串
     */
    public static String generateKey(String seed) {
        return generateKey(seed, DES);
    }

    /**
     * 生成密钥
     * 
     * @param seed 种子
     * @param algorithm 加密算法名称，支持的算法： {@link #DES}、 {@link #DESEDE}、{@link #AES}、
     *            {@link #BLOWFISH}、{@link #RC2}、 {@link #RC4}
     * @return 经过 BASE64 编码的密钥字符串
     */
    public static String generateKey(String seed, String algorithm) {
        SecureRandom secureRandom = (seed == null) ? new SecureRandom() : new SecureRandom(Base64.decodeBase64(seed));
        KeyGenerator kg = Encryptor.getKeyGenerator(algorithm);
        kg.init(secureRandom);
        SecretKey secretKey = kg.generateKey();
        return Base64.encodeBase64String(secretKey.getEncoded());
    }

    /**
     * 将 DES 密钥字符串转换为密钥实例对象
     * @param desKey 经过 BASE64 编码的密钥字符串
     * @return 密钥实例对象
     */
    public static SecretKey getSecretKey(String desKey){
        return getSecretKey(desKey, DES);
    }
    
    /**
     * 将密钥字符串转换为密钥实例对象
     * @param desKey 经过 BASE64 编码的密钥字符串
     * @param algorithm 加密算法名称，支持的算法： {@link #DES}、 {@link #DESEDE}、{@link #AES}、
     *            {@link #BLOWFISH}、{@link #RC2}、 {@link #RC4}
     * @return 密钥实例对象
     */
    public static SecretKey getSecretKey(String desKey, String algorithm) {
        if(StringUtils.isBlank(desKey)) {
            throw new IllegalArgumentException("密钥不能为空。");
        }
        return getSecretKey(Base64.decodeBase64(desKey), algorithm);
    }
    
    /**
     * 将密钥字符串转换为密钥实例对象
     * 
     * @param key 密钥字符串
     * @param algorithm 加密算法名称，支持的算法： {@link #DES}、 {@link #DESEDE}、{@link #AES}、
     *            {@link #BLOWFISH}、{@link #RC2}、 {@link #RC4}
     * @param md5 密钥字符串是否需要经过 MD5 加密，如果为 true，则会对 key 进行加密处理，如果值为 false，则对 key
     *            进行 BASE64 解码处理。.NET 进行 3DES 加密时，默认会对 key 进行 MD5 加密处理，所以与 .NET
     *            程序进行 3DES 加解密数据交互时，需要将该参数值高为 ture。
     * @return 密钥实例对象
     */
    public static SecretKey getSecretKey(String key, String algorithm, boolean md5) {
        if(StringUtils.isBlank(key)) {
            throw new IllegalArgumentException("密钥不能为空。");
        }
        
        byte[] keyBytes = null;
        if(md5) {
            final byte[] digestOfKey = Encryptor.digest(key, Encryptor.MD5);
            keyBytes = Arrays.copyOf(digestOfKey, 24);
            for (int j = 0, k = 16; j < 8;) {
                keyBytes[k++] = keyBytes[j++];
            }
        } else {
            keyBytes = Base64.decodeBase64(key);
        }
        
        return getSecretKey(keyBytes, algorithm);
    }
    
    /** 
     * 将密钥字符串转换为密钥实例对象
     *  
     * @param desKey 密钥
     * @param algorithm 加密算法名称，支持的算法： {@link #DES}、 {@link #DESEDE}、{@link #AES}、
     *            {@link #BLOWFISH}、{@link #RC2}、 {@link #RC4}
     * @return 密钥实例
     */  
    public static SecretKey getSecretKey(byte[] desKey, String algorithm) {
        if(DES.equalsIgnoreCase(algorithm)) {
            try {
                SecretKeyFactory keyFactory = SecretKeyFactory.getInstance(algorithm);  
                DESKeySpec dks = new DESKeySpec(desKey);  
                return keyFactory.generateSecret(dks);
            } catch (NoSuchAlgorithmException e) {
                //throw new GboatSecurityException("算法 [" + algorithm + "] 不存在，或当前  JDK 不支持该算法。", e);
            } catch (Exception e) {
                throw new IllegalArgumentException("将密钥字符串转换为密钥实例对象失败。", e);
            }  
        }
  
        return new SecretKeySpec(desKey, algorithm);
    }
    
    /**
     * 对数据进行 DES 加密
     * @param data 要加密的数据
     * @return 使用默认密钥，经过 BASE64 编码的密文
     */
    public static String encrypt(String data) {
        byte[] entryptBytes = encrypt(data.getBytes(), DEFAULT_KEY);
        return Base64.encodeBase64String(entryptBytes);
    }
    
    /**
     * 对数据进行 DES 加密
     * @param data 要加密的数据
     * @param key 经过 BASE64 编码的密钥字符串
     * @return 经过 BASE64 编码的密文
     */
    public static String encrypt(String data, String key) {
        byte[] entryptBytes = encrypt(data.getBytes(), key);
        return Base64.encodeBase64String(entryptBytes);
    }

    /**
     * 对数据进行 DES 加密
     * @param data 要加密的数据
     * @param key 经过 BASE64 编码的密钥字符串
     * @return 密文
     */
    public static byte[] encrypt(byte[] data, String key) {
        return encrypt(data, key, DES);
    }
    
    /**
     * 对数据进行加密
     * 
     * @param data 要加密的明文数据
     * @param key 经过 BASE64 编码的密钥字符串
     * @param transformation the name of the transformation, format is "Algorithm/Modes/Paddings", e.g.,
     *            DES/CBC/PKCS5Padding. See Appendix A in the <a target="_blank"
     *            href="http://docs.oracle.com/javase/6/docs/technotes/guides/security/crypto/CryptoSpec.html#AppA">
     *            Java Cryptography Architecture Reference Guide</a> for information about standard transformation names.
     * <pre>
     * The following table lists cipher algorithms available in the SunJCE provider:
     * AlgorithmName                            Modes                                               Paddings
     * AES              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB128, OFB, OFB8..OFB128  NOPADDING, PKCS5PADDING, ISO10126PADDING
     * Blowfish         ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * DES              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * DESede           ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * RC2              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * ARCFOUR          ECB                                                             NOPADDING
     * </pre>
     * 
     * @return 密文
     */
    public static byte[] encrypt(byte[] data, String key, String transformation) {  
        Key k = getSecretKey(key, Encryptor.getAlgorithmFromTransformation(transformation));  
        return Encryptor.encrypt(data, k, transformation);
    }
    
    /**
     * 对数据进行加密
     * 
     * @param data 要加密的明文数据
     * @param key 经过 BASE64 编码的密钥字符串
     * @param transformation the name of the transformation, format is "Algorithm/Modes/Paddings", e.g.,
     *            DES/CBC/PKCS5Padding. See Appendix A in the <a target="_blank"
     *            href="http://docs.oracle.com/javase/6/docs/technotes/guides/security/crypto/CryptoSpec.html#AppA">
     *            Java Cryptography Architecture Reference Guide</a> for information about standard transformation names.
     * <pre>
     * The following table lists cipher algorithms available in the SunJCE provider:
     * AlgorithmName                            Modes                                               Paddings
     * AES              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB128, OFB, OFB8..OFB128  NOPADDING, PKCS5PADDING, ISO10126PADDING
     * Blowfish         ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * DES              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * DESede           ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * RC2              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * ARCFOUR          ECB                                                             NOPADDING
     * </pre>
     * 
     * @return 经过 BASE64 编码的密文字符串
     */
    public static String encrypt(String data, String key, String transformation) {
        Key k = getSecretKey(key, Encryptor.getAlgorithmFromTransformation(transformation));
        return encrypt(data, k, transformation);
    }
    
    /**
     * 对数据进行加密
     * 
     * @param data 要加密的明文数据
     * @param key 密钥
     * @param transformation the name of the transformation, format is "Algorithm/Modes/Paddings", e.g.,
     *            DES/CBC/PKCS5Padding. See Appendix A in the <a target="_blank"
     *            href="http://docs.oracle.com/javase/6/docs/technotes/guides/security/crypto/CryptoSpec.html#AppA">
     *            Java Cryptography Architecture Reference Guide</a> for information about standard transformation names.
     * <pre>
     * The following table lists cipher algorithms available in the SunJCE provider:
     * AlgorithmName                            Modes                                               Paddings
     * AES              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB128, OFB, OFB8..OFB128  NOPADDING, PKCS5PADDING, ISO10126PADDING
     * Blowfish         ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * DES              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * DESede           ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * RC2              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * ARCFOUR          ECB                                                             NOPADDING
     * </pre>
     * 
     * @return 经过 BASE64 编码的密文字符串
     */
    public static String encrypt(String data, Key key, String transformation) { 
        byte[] entryptBytes = Encryptor.encrypt(data.getBytes(), key, transformation);
        return Base64.encodeBase64String(entryptBytes);
    }
  
    /**
     * 对数据进行 DES 解密
     * @param data 要解密的数据
     * @return 使用默认密钥，经过 BASE64 编码的密文
     */
    public static String decrypt(String data) {
        byte[] entryptBytes = decrypt(data.getBytes(), DEFAULT_KEY);
        return Base64.encodeBase64String(entryptBytes);
    }

    /**
     * 对数据进行 DES 解密
     * @param data 要解密的数据
     * @param key 经过 BASE64 编码的密钥字符串
     * @return 经过 BASE64 编码的密文
     */
    public static String decrypt(String data, String key) {
        byte[] entryptBytes = decrypt(data.getBytes(), key);
        return Base64.encodeBase64String(entryptBytes);
    }

    /**
     * 对数据进行 DES 解密
     * @param data 要解密的数据
     * @param key 经过 BASE64 编码的密钥字符串
     * @return 密文
     */
    public static byte[] decrypt(byte[] data, String key) {
        return decrypt(data, key, DES);
    }
    
    /**
     * 对数据进行解密
     * 
     * @param data 要解密的明文数据
     * @param key 经过 BASE64 编码的密钥字符串
     * @param transformation the name of the transformation, format is "Algorithm/Modes/Paddings", e.g.,
     *            DES/CBC/PKCS5Padding. See Appendix A in the <a target="_blank"
     *            href="http://docs.oracle.com/javase/6/docs/technotes/guides/security/crypto/CryptoSpec.html#AppA">
     *            Java Cryptography Architecture Reference Guide</a> for information about standard transformation names.
     * <pre>
     * The following table lists cipher algorithms available in the SunJCE provider:
     * AlgorithmName                            Modes                                               Paddings
     * AES              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB128, OFB, OFB8..OFB128  NOPADDING, PKCS5PADDING, ISO10126PADDING
     * Blowfish         ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * DES              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * DESede           ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * RC2              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * ARCFOUR          ECB                                                             NOPADDING
     * </pre>
     * 
     * @return 密文
     */
    public static byte[] decrypt(byte[] data, String key, String transformation) {  
        Key k = getSecretKey(key, Encryptor.getAlgorithmFromTransformation(transformation));  
        return Encryptor.decrypt(data, k, transformation);
    }
    
    /**
     * 对数据进行解密
     * 
     * @param data 要解密的明文数据
     * @param key 经过 BASE64 编码的密钥字符串
     * @param transformation the name of the transformation, format is "Algorithm/Modes/Paddings", e.g.,
     *            DES/CBC/PKCS5Padding. See Appendix A in the <a target="_blank"
     *            href="http://docs.oracle.com/javase/6/docs/technotes/guides/security/crypto/CryptoSpec.html#AppA">
     *            Java Cryptography Architecture Reference Guide</a> for information about standard transformation names.
     * <pre>
     * The following table lists cipher algorithms available in the SunJCE provider:
     * AlgorithmName                            Modes                                               Paddings
     * AES              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB128, OFB, OFB8..OFB128  NOPADDING, PKCS5PADDING, ISO10126PADDING
     * Blowfish         ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * DES              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * DESede           ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * RC2              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * ARCFOUR          ECB                                                             NOPADDING
     * </pre>
     * 
     * @return 经过 BASE64 编码的密文字符串
     */
    public static String decrypt(String data, String key, String transformation) {
        Key k = getSecretKey(key, Encryptor.getAlgorithmFromTransformation(transformation));
        return decrypt(data, k, transformation);
    }
    
    /**
     * 对数据进行解密
     * 
     * @param data 要解密的明文数据
     * @param key 密钥
     * @param transformation the name of the transformation, format is "Algorithm/Modes/Paddings", e.g.,
     *            DES/CBC/PKCS5Padding. See Appendix A in the <a target="_blank"
     *            href="http://docs.oracle.com/javase/6/docs/technotes/guides/security/crypto/CryptoSpec.html#AppA">
     *            Java Cryptography Architecture Reference Guide</a> for information about standard transformation names.
     * <pre>
     * The following table lists cipher algorithms available in the SunJCE provider:
     * AlgorithmName                            Modes                                               Paddings
     * AES              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB128, OFB, OFB8..OFB128  NOPADDING, PKCS5PADDING, ISO10126PADDING
     * Blowfish         ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * DES              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * DESede           ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * RC2              ECB, CBC, PCBC, CTR, CTS, CFB, CFB8..CFB64, OFB, OFB8..OFB64    NOPADDING, PKCS5PADDING, ISO10126PADDING
     * ARCFOUR          ECB                                                             NOPADDING
     * </pre>
     * 
     * @return 经过 BASE64 编码的密文字符串
     */
    public static String decrypt(String data, Key key, String transformation) { 
        byte[] dataBytes = Base64.decodeBase64(data);
        byte[] decryptedBytes = Encryptor.decrypt(dataBytes, key, transformation);
        return new String(decryptedBytes);
    }

}
