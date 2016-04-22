package com.ht.test.service;

import com.ht.test.error.HTException;

public interface TransportService {
	public String getAgencies() throws HTException;
	public String getRoutesForAgency(String agencyName) throws HTException;
	public String getStopsForRoute(String agencyName, String routeCode) throws HTException;
	public String getTimingsForStop(String agencyName, String stopCode) throws HTException;
}
