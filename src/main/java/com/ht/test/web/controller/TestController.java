package com.ht.test.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ht.test.service.TransportService;
import com.ht.test.util.CommonUtil;
import com.ht.test.web.dto.response.HTApiResponse;

@Controller
public class TestController {
	@Autowired
	TransportService transportService;
	
	@RequestMapping("/")
	public String fowreport(){
		return "index";
	}
	
	@RequestMapping("/api/getAgencies")
	public @ResponseBody String getAgencies(){
		HTApiResponse resp = new HTApiResponse();
		try{
			resp.setData(transportService.getAgencies());
		} catch(Exception e){
			resp.setError(e);
		}
		return CommonUtil.getJsonString(resp);
	}
	
	@RequestMapping("/api/getRoutesForAgency")
	public @ResponseBody String getRoutesForAgency(String agencyName){
		HTApiResponse resp = new HTApiResponse();
		try{
			resp.setData(transportService.getRoutesForAgency(agencyName));
		} catch(Exception e){
			resp.setError(e);
		}
		return CommonUtil.getJsonString(resp);
	}
	
	@RequestMapping("/api/getStopsForRoute")
	public @ResponseBody String getStopsForRoute(String agencyName, String routeCode){
		HTApiResponse resp = new HTApiResponse();
		try{
			resp.setData(transportService.getStopsForRoute(agencyName, routeCode));
		} catch(Exception e){
			resp.setError(e);
		}
		return CommonUtil.getJsonString(resp);
	}
	
	@RequestMapping("/api/getTimingsForStop")
	public @ResponseBody String getTimingsForStop(String agencyName, String stopCode){
		HTApiResponse resp = new HTApiResponse();
		try{
			resp.setData(transportService.getTimingsForStop(agencyName, stopCode));
		} catch(Exception e){
			resp.setError(e);
		}
		return CommonUtil.getJsonString(resp);
	}
}
