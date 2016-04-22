<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>Transport app</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.4/angular.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/HTUtils.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/serviceLayer.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/main.ctrl.js"></script>
</head>
<body ng-app="app" ng-controller="MainController as main">
	<div class="container">
	    <h1>{{main.title}}</h1>
	    <div class="input-group">
	        <span class="input-group-addon">
	            <span class="glyphicon glyphicon-search"></span>
	        </span>
	        <input type="text" class="form-control" ng-model="main.searchInput">
	    </div>
	    <div class="agency-list-container view-section" ng-if="main.viewName == 'AGENCY_LIST'">
		    <h3>List of travel agencies</h3>
		    <ul class="list-group">
		        <li class="list-group-item" ng-repeat="agency in main.agencies | filter:main.searchInput">
		        	<a href="javascript:;" ng-click="main.showRoutes(agency);" style="cursor: pointer;">{{agency.Name}}</a> 
		        	<span class="badge">{{agency.Mode}}</span>
		        </li>
		    </ul>
	    </div>
	    
	   	<div class="route-list-container view-section" ng-if="main.viewName == 'ROUTE_LIST'">
		    <h3>List of travel routes for <strong>{{main.activeAgency.Name}}</strong></h3>
		    <ul class="list-group">
		        <li class="list-group-item" ng-repeat="route in main.routes | filter:main.searchInput">
		        	<a href="javascript:;" ng-click="main.showStops(route);" style="cursor: pointer;">{{route.Name}}</a> 
		        	<span class="badge">{{agency.Mode}}</span>
		        </li>
		    </ul>
	    </div>
	    
	   	<div class="stop-list-container view-section" ng-if="main.viewName == 'STOP_LIST'">
		    <h3>List of stops for <strong>{{main.activeRoute.Name}}</strong></h3>
		    <ul class="list-group">
		        <li class="list-group-item" ng-repeat="stop in main.stops | filter:main.searchInput">
		        	<a href="javascript:;" ng-click="main.showTimings(stop);" style="cursor: pointer;">{{stop.name}}</a> 
		        	<span class="badge">{{agency.Mode}}</span>
		        </li>
		    </ul>
	    </div>
	    
	   	<div class="timing-list-container view-section" ng-if="main.viewName == 'TIMINGS'">
		    <h3>Departure time for <strong>{{main.activeStop.name}}</strong></h3>
		    <ul class="list-group">
		        <li class="list-group-item" ng-repeat="route in main.timings | filter:main.searchInput">
		        	<span>Available on <strong>{{route.Name}}</strong> route </span> 
		        	<span class="badge" ng-repeat="timing in route.timings">in {{timing.time}} min at {{timing.hours}} : {{timing.minutes}}</span> &nbsp;
		        </li>
		    </ul>
	    </div>
	</div>
</body>
</html>