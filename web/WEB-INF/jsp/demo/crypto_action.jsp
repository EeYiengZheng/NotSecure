<%@ page import = "java.security.*, javax.crypto.*, javax.crypto.spec.*, java.util.*, java.io.*" %><%
String etype = request.getParameter( "etype" );
String keyStr = request.getParameter( "key" );
String algo = request.getParameter( "algo" );
String indata = request.getParameter( "indata" );
String encoding = request.getParameter( "encoding" );

byte[] k = keyStr.getBytes();
byte[] pt = indata.getBytes();
if ( encoding.equalsIgnoreCase("Base64") ) { //Base64 encoded
	pt = Base64.getDecoder().decode(indata);
}

//Do encryption: RC4
Cipher rc4 = Cipher.getInstance("RC4");
Key key = new SecretKeySpec(k,"RC4");

if ( etype.equalsIgnoreCase("encrypt") ) { //Encryption
	rc4.init(Cipher.ENCRYPT_MODE ,key);
	byte[] ct = rc4.doFinal(pt);
	out.println( "Output: " + Arrays.toString(ct) + "<br>" );
	out.println( new String( Base64.getEncoder().encode(ct) ) );
} else { //Decryption
	rc4.init(Cipher.DECRYPT_MODE ,key);
	byte[] pt2 = rc4.doFinal(pt);
	out.println( new String( pt2 ) );
}
%>