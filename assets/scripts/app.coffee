'use strict'
React = require 'react'



App = React.createClass
	render: ->
		<h1>hello</h1>


React.render <App />, document.getElementById 'container'
