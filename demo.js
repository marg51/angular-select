app = angular.module('mgApp', ['mg-select']);

app.directive('demoTextarea', function (mgSelectService) {
	return function (scope, elm, attr) {

			// every time user click (`mouseup` event) on a text
			scope.$watch('incr', function () {
				mgSelectService.setSelection(elm[0]);

				// update the inputs
				selection = mgSelectService.selection
				scope.form.cursor = scope.form.start = selection[0]
				scope.form.end = selection[1]
			});

			// Update the selection from the view
			scope.update = function () {
				mgSelectService.setSelectionRange(elm[0],scope.form.start,scope.form.end);
			};
		}
});

app.controller('demoCtrl', function ($scope) {
	$scope.data = ["demo text #1", "I made a typo, can you crret it ?", "something cooler than anything else"];
	
	$scope.incr = -1;
	$scope.current = 0;
	$scope.form = {}
	$scope.setCurrent = function (index) {
		$scope.current = index;
		// we $watch .incr instead of .current since .current may not change but our position does
		$scope.incr++;
	}
});