var ActivityApp = angular.module("ActivityApp",[]);

ActivityApp.controller('ServiceController', ServiceController);

function ServiceController($scope, $http) {
    $scope.name = "b";
    $scope.callService = function () {

        var proxy = new WcfService.ActivityWcf();
        proxy.GetTime(successServiceCall, errorServiceCall, null);
        $scope.ErrorMessage = "";
    }
    var successServiceCall = function (data) {
        $scope.hello = data;
        $scope.$digest();
    }
    var errorServiceCall = function (data) {
        $scope.ErrorMessage = "HTTP error code : " + data;
        $scope.$digest();
    }
};