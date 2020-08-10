package com.bizwink.util;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import java.io.ByteArrayOutputStream;
import java.security.Key;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class SecurityUtil {
    public static String DES = "AES"; // optional value AES/DES/DESede

    public static String CIPHER_ALGORITHM = "AES"; // optional value AES/DES/DESede

    private static final String DES_ALGORITHM = "DES";

    private static String key = "edarongedarongedarongbizwinkbizwinkedarongedarongedarongbizwinkbizwink"; // optional value AES/DES/DESede

    private final static BASE64Encoder base64encoder = new BASE64Encoder();

    private final static BASE64Decoder base64decoder = new BASE64Decoder();

    private final static String encoding = "UTF-8";

    /**
     * 加密字符串
     */
    public static String Encrypto(String str) {
        String result = str;
        if (str != null && str.length() > 0) {
            try {
                byte[] encodeByte = symmetricEncrypto(str.getBytes(encoding));
                result = base64encoder.encode(encodeByte);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 解密字符串
     */
    public static String Decrypto(String str) {
        String result = str;
        if (str != null && str.length() > 0) {
            try {
                byte[] encodeByte = base64decoder.decodeBuffer(str);
                byte[] decoder = symmetricDecrypto(encodeByte);
                result = new String(decoder, encoding);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }

    /**
     * 对称加密方法
     *
     * @param byteSource
     *            需要加密的数据
     * @return 经过加密的数据
     * @throws Exception
     */
    public static byte[] symmetricEncrypto(byte[] byteSource) throws Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            int mode = Cipher.ENCRYPT_MODE;
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            byte[] keyData = key.getBytes();
            DESKeySpec keySpec = new DESKeySpec(keyData);
            Key key = keyFactory.generateSecret(keySpec);
            Cipher cipher = Cipher.getInstance("DES");
            cipher.init(mode, key);
            byte[] result = cipher.doFinal(byteSource);
// int blockSize = cipher.getBlockSize();
// int position = 0;
// int length = byteSource.length;
// boolean more = true;
// while (more) {
// if (position + blockSize <= length) {
// baos.write(cipher.update(byteSource, position, blockSize));
// position += blockSize;
// } else {
// more = false;
// }
// }
// if (position < length) {
// baos.write(cipher.doFinal(byteSource, position, length
// - position));
// } else {
// baos.write(cipher.doFinal());
// }
// return baos.toByteArray();
            return result;
        } catch (Exception e) {
            throw e;
        } finally {
            baos.close();
        }
    }

    /**
     * 对称解密方法
     *
     * @param byteSource
     *            需要解密的数据
     * @return 经过解密的数据
     * @throws Exception
     */
    public static byte[] symmetricDecrypto(byte[] byteSource) throws Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        try {
            int mode = Cipher.DECRYPT_MODE;
            SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
            //byte[] keyData = { 1, 9, 8, 2, 0, 8, 2, 1 };
            byte[] keyData = key.getBytes();
            DESKeySpec keySpec = new DESKeySpec(keyData);
            Key key = keyFactory.generateSecret(keySpec);
            Cipher cipher = Cipher.getInstance("DES");
            cipher.init(mode, key);
            byte[] result = cipher.doFinal(byteSource);
// int blockSize = cipher.getBlockSize();
// int position = 0;
// int length = byteSource.length;
// boolean more = true;
// while (more) {
// if (position + blockSize <= length) {
// baos.write(cipher.update(byteSource, position, blockSize));
// position += blockSize;
// } else {
// more = false;
// }
// }
// if (position < length) {
// baos.write(cipher.doFinal(byteSource, position, length
// - position));
// } else {
// baos.write(cipher.doFinal());
// }
// return baos.toByteArray();
            return result;
        } catch (Exception e) {
            throw e;
        } finally {
            baos.close();
        }
    }

    /**
     * 散列算法
     *
     * @param byteSource
     *            需要散列计算的数据
     * @return 经过散列计算的数据
     * @throws Exception
     */
    public static byte[] hashMethod(byte[] byteSource) throws Exception {
        try {
            MessageDigest currentAlgorithm = MessageDigest.getInstance("SHA-1");
            currentAlgorithm.reset();
            currentAlgorithm.update(byteSource);
            return currentAlgorithm.digest();
        } catch (Exception e) {
            throw e;
        }
    }

    /**
     * 获得秘密密钥
     *
     * @param secretKey
     * @return
     * @throws java.security.NoSuchAlgorithmException
     */
    private static SecretKey getSecretKey(String secretKey) throws NoSuchAlgorithmException{
        if (secretKey == null) secretKey = key;
        SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG");
        secureRandom.setSeed(secretKey.getBytes());
        // 为我们选择的DES算法生成一个KeyGenerator对象
        KeyGenerator kg = null;
        try {
            kg = KeyGenerator.getInstance(DES);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        kg.init(secureRandom);
        //kg.init(56, secureRandom);

        // 生成密钥
        return kg.generateKey();
    }

    public static String encrypt(String data,String key) throws Exception
    {
        if (key == null) key = SecurityUtil.key;
        SecureRandom sr = new SecureRandom();
        Key securekey = getSecretKey(key);
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
        //Cipher cipher = Cipher.getInstance("DES/ECB/NoPadding");
        cipher.init(Cipher.ENCRYPT_MODE, securekey, sr);
        byte[] bt = cipher.doFinal(data.getBytes());
        String strs = new BASE64Encoder().encode(bt);
        return strs;
    }

    public  static String detrypt(String message,String key) throws Exception{
        if (key == null) key = SecurityUtil.key;
        SecureRandom sr = new SecureRandom();
        Cipher cipher = Cipher.getInstance(CIPHER_ALGORITHM);
        //Cipher cipher = Cipher.getInstance("DES/ECB/NoPadding");
        Key securekey = getSecretKey(key);
        cipher.init(Cipher.DECRYPT_MODE, securekey,sr);
        byte[] res = new BASE64Decoder().decodeBuffer(message);
        res = cipher.doFinal(res);
        return new String(res);
    }

    public static void main(String[] args)throws Exception{
        String message = "password";
        String key = "";
        String entryptedMsg = SecurityUtil.Encrypto(message);
        System.out.println("encrypted message is below :");
        System.out.println(entryptedMsg);

        String decryptedMsg = SecurityUtil.Decrypto(entryptedMsg);
        System.out.println("decrypted message is below :");
        System.out.println(decryptedMsg);
    }


}
