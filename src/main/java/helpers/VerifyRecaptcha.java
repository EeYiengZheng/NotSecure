package main.java.helpers;

import com.eclipsesource.json.Json;
import com.eclipsesource.json.JsonObject;

import javax.net.ssl.HttpsURLConnection;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;

/**
 * with modification,
 * Credit to Pankaj Kumar
 * https://www.journaldev.com/7133/how-to-integrate-google-recaptcha-in-java-web-application
 */
public class VerifyRecaptcha {

    private static final String url = "https://www.google.com/recaptcha/api/siteverify";
    private static final String secret = "6LcaOz0UAAAAAHM_SpAPU1D8HS-vvjyWT4mikqo5";
    private final static String USER_AGENT = "Mozilla/5.0";

    public static boolean verify(String gRecaptchaResponse) throws IOException {
        if (gRecaptchaResponse == null || "".equals(gRecaptchaResponse)) {
            return false;
        }

        try{
            URL obj = new URL(url);
            HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();

            // add request header
            con.setRequestMethod("POST");
            con.setRequestProperty("User-Agent", USER_AGENT);
            con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");

            String postParams = "secret=" + secret + "&response="
                    + gRecaptchaResponse;

            // Send post request
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(postParams);
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            System.out.println("\nSending 'POST' request to URL : " + url);
            System.out.println("Response Code : " + responseCode);

            BufferedReader in = new BufferedReader(new InputStreamReader(
                    con.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();

            // print result
            System.out.println(response.toString());

            //parse JSON response and return 'success' value

            JsonObject jsonObject = Json.parse(response.toString()).asObject();

            return jsonObject.getBoolean("success", false);
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }
}