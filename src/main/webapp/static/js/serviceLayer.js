/*This Utility makes API calls to server for fetching data*/
var ServiceManager = (function(){
    return {};
})();

ServiceManager.cloudUrl = "/testapp/";
ServiceManager.sendRequest = function(serviceUrl, asyncFlag, methodFlag, serializeFunc, callback){
    var webserviceUrl = this.cloudUrl + serviceUrl;		                
    try{
        $.ajax({
            url: webserviceUrl,
            dataType : "json",
            jsonp:false,
            type : methodFlag,
            async: asyncFlag,
            data : this.sendData,
            success: function(data, textStatus, XMLHttpObj){        
                if(textStatus == "success"){
					if (data == null) {
						/* 
						 * This is a misc error case which happens when calls are interrupted, usually by refreshing/clicking
						 * bookmark before page is loaded. It is unlikely that we want to display a message for this error case. 
						 */
					} else if (!data.error){
                    	/*
                    	 * No error returned from server
                    	 */
                        var obj = serializeFunc(data);
                        if (typeof callback != 'undefined') { 
                        	callback(obj); 
                        } else { 
                        	return obj; 
                        }
                    } else { 
                        /*
                         * Client side error handling
                         */
                        var errorMsg = data.error.message;
                        MessageUtil.error(errorMsg);
                    }
                }
            },
			statusCode: {
				500: function() {
					/* 
					 * This should never happen because 500 errors are captured by the server and redirected
					 * to a special 500 error page. 
					 */
					MessageUtil.error("Internal Error Occurred. If Please contact customer support.");
					alert('Still need to add ajax error handling for a 500 error in ServiceManager.sendRequest');
				}
			},
            error : function(XMLHttpObj, textStatus, errorThrown){
				/* 
				 * This is a misc error case which happens when calls are interrupted, usually by refreshing/clicking
				 * bookmark before page is loaded. It is unlikely that we want to display a message for this error case. 
				 */
            	MessageUtil.error(errorThrown);
            },
            beforeSend : function(xhr){
            	/* CdaTimeout.onAjaxSend(); */
            }
        });
    }
    catch(error){
        MessageUtil.error(error.message);
    }
};

ServiceManager.post = function(url, oRequest, callback){
	try{
		var obj;
		var asyncFlag = callback ? true : false;
		var methodFlag = "POST";			
		this.sendData = JSON.stringify(oRequest);
		serviceUrl = url;
		this.sendRequest(serviceUrl, asyncFlag, methodFlag, function(alfa){return alfa;}, function(result) { 
			obj = result;
			if(callback){
				callback(result);
			}
		});
		return obj;
	}
	catch(error){
		MessageUtil.error("Some Error occured in ServiceManager, postRequest method");
	}

};

ServiceManager.get = function(url, callback){
	try{
		var obj;
		var asyncFlag = callback ? true : false;
		var methodFlag = "GET";			
		serviceUrl = url;
		this.sendRequest(serviceUrl, asyncFlag, methodFlag, function(alfa){return alfa;}, function(result) { 
			obj = result;
			if(callback){
				callback(result);
			}
		});
		return obj;
	}
	catch(error){
		MessageUtil.error("Some Error occured in ServiceManager, getRequest method");
	}
};

ServiceManager.getAgencies = function(){
	var agenciesResp = JSON.parse(ServiceManager.get('api/getAgencies').data);
	if(agenciesResp && agenciesResp.RTT && agenciesResp.RTT.AgencyList && agenciesResp.RTT.AgencyList.Agency){
		return agenciesResp.RTT.AgencyList.Agency;
	}
};

ServiceManager.getRoutesForAgency = function(agency){
	var routesResp = JSON.parse(ServiceManager.get('api/getRoutesForAgency?agencyName='+agency.Name).data);
	if(routesResp && routesResp.RTT && routesResp.RTT.AgencyList && routesResp.RTT.AgencyList.Agency && routesResp.RTT.AgencyList.Agency.RouteList && routesResp.RTT.AgencyList.Agency.RouteList.Route){
		return routesResp.RTT.AgencyList.Agency.RouteList.Route;
	}
};

ServiceManager.getStopsForRoute = function(agency, route){
	var stopsResp = JSON.parse(ServiceManager.get('api/getStopsForRoute?agencyName='+agency.Name+'&routeCode='+route.Code).data);
	if(stopsResp && stopsResp.RTT && stopsResp.RTT.AgencyList 
			&& stopsResp.RTT.AgencyList.Agency && stopsResp.RTT.AgencyList.Agency.RouteList
			&& stopsResp.RTT.AgencyList.Agency.RouteList.Route.StopList){
		return stopsResp.RTT.AgencyList.Agency.RouteList.Route.StopList.Stop;
	}
};

ServiceManager.getTimingsForStop = function(agency, stop){
	var timingsResp = JSON.parse(ServiceManager.get('api/getTimingsForStop?agencyName='+agency.Name+'&stopCode=' + stop.StopCode).data);
	if(timingsResp && timingsResp.RTT && timingsResp.RTT.AgencyList 
			&& timingsResp.RTT.AgencyList.Agency && timingsResp.RTT.AgencyList.Agency.RouteList 
			&& timingsResp.RTT.AgencyList.Agency.RouteList.Route){
		var retVal = [];
		var routes = timingsResp.RTT.AgencyList.Agency.RouteList.Route;
		for(var i=0; i<routes.length; i++){
			var route = routes[i];
			var routeTiming = {Name : route.Name, timings: []};
			if(route && route.StopList && route.StopList.Stop && route.StopList.Stop.DepartureTimeList && route.StopList.Stop.DepartureTimeList.DepartureTime){
				var timings = route.StopList.Stop.DepartureTimeList.DepartureTime;
				if(timings.length){
					retVal.push(routeTiming);
				}
				for(var j=timings.length-1; j!=0; j--){
					var timing = timings[j];
					var timeDate = new Date((new Date()).getTime()+timing*60000);
					routeTiming.timings.push({time: timing, hours: timeDate.getHours(), minutes: timeDate.getMinutes()});
				}
			}
		}
		return retVal;
	}
};
