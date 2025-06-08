package kr.co.gungon.util;

import java.security.MessageDigest;

public class EncryptUtil {
    public static String sha256(String password) {
        StringBuffer sb = new StringBuffer();

        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(password.getBytes("UTF-8"));
            byte[] digest = md.digest();

            for (byte b : digest) {
                sb.append(String.format("%02x", b));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return sb.toString();
    }

    public static void main(String[] args) {
        String raw = "gungadmin"; // 최초 비밀번호
        String hashed = sha256(raw);
        System.out.println("암호화된 비밀번호: " + hashed);
    }
}