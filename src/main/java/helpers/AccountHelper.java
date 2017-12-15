package main.java.helpers;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.MessageDigest;
import java.util.Random;

public class AccountHelper {
    private static final Random random = new SecureRandom();

    /**
     * generates a secure random 8 bytes salt
     * @return 8 bytes salt
     */
    public static byte[] getNewSalt() {
        byte[] salt = new byte[8];
        random.nextBytes(salt);
        return salt;
    }

    /**
     * return a hash(salt + password) hashed password
     * use this instead of mysql built-in hasher to avoids sql-injection
     * @param salt the salt
     * @param password the password
     * @return hashed password
     */
    public static byte[] hash(byte[] salt, byte[] password) {
        try {
            MessageDigest md = MessageDigest.getInstance("sha-256");
            byte[] saltedPassword = new byte[salt.length + password.length];
            System.arraycopy(salt, 0, saltedPassword, 0, salt.length);
            System.arraycopy(password, 0, saltedPassword, salt.length, password.length);
            return md.digest(saltedPassword);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return new byte[]{};
    }

    public static String toHex(byte[] bytes) {
        return javax.xml.bind.DatatypeConverter.printHexBinary(bytes).toLowerCase();
    }

    public static byte[] toByte(String hexString) {
        return javax.xml.bind.DatatypeConverter.parseHexBinary(hexString.toUpperCase());
    }

}