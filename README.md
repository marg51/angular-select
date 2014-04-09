# angular-select

![](http://i.uto.io/jg5MD)

[demo](http://select.uto.io/)

angular-select help you to manage the selection.

## How to use

#### add the dependency

```javascript
var app = angular.module('myApp', ['mg-select']);
```

#### mgSelectService

Update the selection of your element based on the last selection of the user

```javascript
app.directive('myDirective', function (mgSelectService) {
	return function (scope, elm, attrs) {
		mgSelectService.setSelection(elm[0]);
	}
});
```


##### Methods

- setSelection
- updateSelection
- setSelectionRange
- deepCount

##### properties

- selection


***

Tested with Firefox and Chrome

***

## TODO

Improve the docs ( How did I achieve the gif example ? )
Improve the demo

Does it work with Safari and IE ? 

Tests


