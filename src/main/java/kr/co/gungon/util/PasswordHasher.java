package kr.co.gungon.util; 
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PasswordHasher {

    /**
     * @param password 해싱할 원본 비밀번호
     * @return 해싱된 비밀번호 (16진수 문자열)
     * @throws NoSuchAlgorithmException SHA-256 알고리즘을 찾을 수 없을 때 발생
     */
    public static String hashPassword(String password) throws NoSuchAlgorithmException {
        // SHA-256 MessageDigest 인스턴스 얻기
        MessageDigest md = MessageDigest.getInstance("SHA-256");

        // 비밀번호를 바이트 배열로 변환하여 해싱
        md.update(password.getBytes());
        byte[] hashedBytes = md.digest();

        // 해싱된 바이트 배열을 16진수 문자열로 변환
        StringBuilder sb = new StringBuilder();
        for (byte b : hashedBytes) {
            sb.append(String.format("%02x", b)); // 각 바이트를 2자리 16진수로 포맷
        }
        return sb.toString();
    }
}