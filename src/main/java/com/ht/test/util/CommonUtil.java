package com.ht.test.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Map;
import java.util.zip.GZIPInputStream;

import javax.xml.bind.DatatypeConverter;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.json.XML;

import com.google.gson.Gson;
import com.ht.test.error.HTException;

public class CommonUtil {
	protected static Logger logger = Logger.getLogger(CommonUtil.class);
	private static Gson gson = new Gson();
	
	public static String getJsonString(Object obj){
		try{
			//ObjectMapper mapper = new ObjectMapper();
			//mapper.configure(SerializationFeature.WRITE_NULL_MAP_VALUES, false);
			return gson.toJson(obj);
			//return mapper.writeValueAsString(obj);
		} catch(Exception e){
			logger.error(e);
		}
		return null;
	}
	
	public static String getJSONFromXML(String xmlString){
		if(xmlString!=null){
			JSONObject jsonObject = XML.toJSONObject(xmlString);
			if(jsonObject!=null){
				return jsonObject.toString();
			}
		}
		return null;
	}
	
	public static String getHttpCallResponse(String url) throws HTException {
		return getHttpCallResponse(url, null, null, null);
	}
	
	public static String getHttpCallResponse(String url, String authUser, String authPass, Map<String, String> headers) throws HTException {
		try {
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();
			
			if(authUser != null && authPass != null){
				String userpass = authUser + ":" + authPass;
				String basicAuth = "Basic " + DatatypeConverter.printBase64Binary(userpass.getBytes());
				con.setRequestProperty ("Authorization", basicAuth);
			}
			if(headers!=null){
				for(String key : headers.keySet()){
					con.setRequestProperty(key, headers.get(key));
				}
			}
			//add reuqest header
			con.setRequestMethod("GET");
			//con.setRequestProperty("User-Agent", USER_AGENT);
			con.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
			con.setConnectTimeout(60000);
			con.setReadTimeout(60000);
	 
			con.getResponseCode();
			String contentEncoding = con.getHeaderField("Content-Encoding");
			BufferedReader in = null;
			if("gzip".equalsIgnoreCase(contentEncoding)){
				in = new BufferedReader(new InputStreamReader(new GZIPInputStream(con.getInputStream())));
			} else {
				in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
	 
			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close();
	 
			return response.toString();
		} catch(Exception e){
			throw new HTException(e);
		}
	}
	
	public static String encodeURIComponent(String s) {
		String result = s;
		if(s!=null){
			try {
				result = URLEncoder.encode(s, "UTF-8")
						.replaceAll("\\+", "%20")
						.replaceAll("\\%21", "!")
						.replaceAll("\\%27", "'")
						.replaceAll("\\%28", "(")
						.replaceAll("\\%29", ")")
						.replaceAll("\\%7E", "~");
			} catch (UnsupportedEncodingException e) {
				logger.error("Error while encoding " + s, e);
			}
		}
		return result;
	}
}
