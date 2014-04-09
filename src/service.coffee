angular.module('mg-select', [])
	.factory 'mgSelectService', ($window) ->

		$scope = {}
		$scope.selection = [0,0]

		###
			Set selection to the `elm` / position of cursor
			@param elm DomNode textarea or input that we update the selection
			@param updateSelection boolean 

			@return this
		###
		$scope.setSelection = (elm, updateSelection = true) ->
			if updateSelection is true
				$scope.updateSelection()

			$scope.setSelectionRange(elm, $scope.selection[0], $scope.selection[1])

			return $scope



		###
			Update position based on the current selection, or last position of click
			@param elm DomNode|jQliteElement|null, we define selection against that parent element instead of the first parent found

			@return this
		###
		$scope.updateSelection = (elm = null) ->
			
			#			Chrome + Firefox
			selection 	= $window.getSelection() 	|| {}

			# 			Chrome						Firefox 					Others
			start 		= selection.baseOffset 		|| selection.anchorOffset 	|| 0
			end			= selection.extentOffset 	|| selection.focusOffset 	|| 0
			baseNode 	= selection.baseNode 		|| selection.anchorNode 	|| 0

			# This is also done in .setSelectionRange() but we may need to access to $scope.selection outside the module
			if start > end
				 [end, start] = [start, end]


			increment 	= 0
			
			# position based on an element ?
			if elm?
				#			jQlite		DomNode
				parent 		= elm[0] 	|| elm
				increment 	= $scope.deepCount(parent, baseNode)

			$scope.selection = [start + increment, end + increment]


			return $scope

		###
			Low level setSelection based on positions given

			@param elm DomNode
			@param selectionStart int
			@param selectionEnd int
		###
		$scope.setSelectionRange = (elm, selectionStart, selectionEnd) ->
			if selectionStart > selectionEnd
				 [selectionEnd, selectionStart] = [selectionStart, selectionEnd]

			if elm.createTextRange
				range = elm.createTextRange()
				range.collapse(true)
				range.moveEnd('character', selectionEnd)
				range.moveStart('character', selectionStart)
				range.select()

			else if elm.setSelectionRange isnt undefined
				# Firefox requires the element to have the focus, Chrome doesn't
				elm.focus()
				elm.setSelectionRange(selectionStart, selectionEnd)


		###
			Determine positions based on the parent node

			@param parentNode DomNode
			@parent baseNode DomNode
		###
		$scope.deepCount = (parentNode, baseNode) ->
			count = 0
			found = false

			forloop = (parentNode, baseNode) ->

				for child in parentNode.childNodes
					if found or child is baseNode
						found = true
						break
					if child.nodeType is 3 and child isnt baseNode
						count += child.length
					if child.nodeType is 1 and child.childNodes.length > 0
						forloop(child, baseNode)
					# WARNING : we guess BR is converted to \n, but is it true ?
					# this may lead to wrong selection
					else if child.nodeName is "BR"
						count++

				return count

			forloop(parentNode,baseNode)

			return count

		

		return $scope


