package com.ht.test.service.impl;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.ht.test.error.HTException;
import com.ht.test.service.TransportService;
import com.ht.test.util.CommonUtil;

/**
 * @author priyank.garg
 *
 */
@Service
public class TransportServiceImpl implements TransportService{
	private static final Logger logger = Logger.getLogger(TransportServiceImpl.class);
	private static String AGENCY_NAME_MACRO = "{AGENCY_NAME}";
	private static String ROUTE_CODE_MACRO = "{ROUTE_CODE}";
	private static String STOP_CODE_MACRO = "{STOP_CODE}";
	
	@Value("${transport.api.getAgencies.url}")
	private String getAgenciesUrl;
	
	@Value("${transport.api.getRoutes.url}")
	private String getRoutesUrl;
	
	@Value("${transport.api.getStops.url}")
	private String getStopsUrl;
	
	@Value("${transport.api.getTimings.url}")
	private String getTimingsUrl;
	
    /**
     * Fetches agencies using the public API
     * 
     * @return Agency List in JSON
     */
	public String getAgencies() throws HTException {
		String xmlResp = CommonUtil.getHttpCallResponse(getAgenciesUrl);
		return CommonUtil.getJSONFromXML(xmlResp);
	}
	
    /**
     * Fetches routes for an agency using the public API
     *
     * @param  agencyName The name of the agency for which routes are requested
     * @return Routes in JSON
     */
	public String getRoutesForAgency(String agencyName) throws HTException {
		String serviceUrl = getRoutesUrl.replace(AGENCY_NAME_MACRO, CommonUtil.encodeURIComponent(agencyName));
		String xmlResp = CommonUtil.getHttpCallResponse(serviceUrl);
		return CommonUtil.getJSONFromXML(xmlResp);
	}
	
    /**
     * Fetches stops for an agency and route using the public API
     *
     * @param  agencyName The name of the agency for which stops are requested
     * @param  routeCode The code for the route for which stops are requested
     * @return Stops in JSON
     */
	public String getStopsForRoute(String agencyName, String routeCode) throws HTException {
		String serviceUrl = getStopsUrl.replace(AGENCY_NAME_MACRO, CommonUtil.encodeURIComponent(agencyName))
				.replace(ROUTE_CODE_MACRO, CommonUtil.encodeURIComponent(routeCode));
		String xmlResp = CommonUtil.getHttpCallResponse(serviceUrl);
		return CommonUtil.getJSONFromXML(xmlResp);
	}
	
    /**
     * Fetches Timings for an agency using the public API
     *
     * @param  agencyName The name of the agency for which timings are requested
     * @param  stopCode The code for the Stop for which timings are requested
     * @return Routes in JSON
     */
	public String getTimingsForStop(String agencyName, String stopCode) throws HTException {
		String serviceUrl = getTimingsUrl.replace(AGENCY_NAME_MACRO, CommonUtil.encodeURIComponent(agencyName))
				.replace(STOP_CODE_MACRO, CommonUtil.encodeURIComponent(stopCode));
		String xmlResp = CommonUtil.getHttpCallResponse(serviceUrl);
		return CommonUtil.getJSONFromXML(xmlResp);
	}
}
