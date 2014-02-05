'use strict';

/* App Module */

var cs462App = angular.module('cs462App', [
	'ngRoute',
	'cs462Controllers',
	'cs462Services'
]);

cs462App.config(['$routeProvider',
	function($routeProvider) {
		$routeProvider.
		when('/account', {
			templateUrl: 'partials/account.html',
			// controller: 'MainCtrl'
		}).
		otherwise({
			templateUrl: 'partials/users.html',
			// controller: 'MainCtrl'
		})
	}
]);