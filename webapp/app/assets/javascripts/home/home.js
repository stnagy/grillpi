angular.module('Grillpi.Home', [
  'ui.router', 
  'templates',
  'ngMaterial',
  'ngMdIcons'
])

  .config(function($stateProvider){
  $stateProvider

    .state('grillpi.landing',{
    url: '/',
    views: {
      'main@': { // target the 'main' ng-view directive
        controller: 'LandingPageCtrl as landingPageCtrl',
        templateUrl: 'home/home.tmpl.html'
      }
    }
  })
})

// Landing page controller
  .controller('LandingPageCtrl', function ($mdDialog, $window){
  var landingPageCtrl = this;

  landingPageCtrl.appName = "Grillpi"; 
})
;