angular.module('app').controller("MainController", function(){
	var vm = this;
	vm.viewName = 'AGENCY_LIST';
	vm.title = 'Transport timing application';
	vm.searchInput = '';
	/*Populating agencies when the page loads*/
	vm.agencies = ServiceManager.getAgencies();

	vm.new = {};

	/*Handler for showing routes for an agency*/
	vm.showRoutes = function(agency) {
		vm.searchInput = '';
		vm.activeAgency = agency;
		vm.viewName = 'ROUTE_LIST';
		vm.routes = ServiceManager.getRoutesForAgency(agency);
	};
	
	/*Handler for showing stops for a route*/
	vm.showStops = function(route) {
		vm.searchInput = '';
		vm.activeRoute = route;
		vm.viewName = 'STOP_LIST';
		vm.stops = ServiceManager.getStopsForRoute(vm.activeAgency, route);
	};
	
	/*Handler for showing timing for a stop*/
	vm.showTimings = function(stop) {
		vm.searchInput = '';
		vm.activeStop = stop;
		vm.viewName = 'TIMINGS';
		vm.timings = ServiceManager.getTimingsForStop(vm.activeAgency, stop);
	};
});