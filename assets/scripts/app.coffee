'use strict'
React = require 'react'
randomColor = require 'randomcolor'


Starter = React.createClass
	getInitialState: ->
		value: ''
		color: ''

	onChange: (e) ->
		@setState value: e.target.value
		do @changeColor

	changeColor: ->
		@setState color: randomColor luminosity: 'light'

	render: ->
		<div className='starter'>
			<div
				style={backgroundColor: @state.color}
				className='starter__color-picker'
				onClick=@changeColor
			/>
			<form>
				<input
					className='starter__input'
					value=@state.value
					onChange=@onChange
					/>
				<input
					className='starter__submit'
					value='Старт'
					type='submit'
				/>
			</form>
		</div>


App = React.createClass
	render: ->
		<div>
			<header className='header'>React Time Tracker</header>
			<Starter />
		</div>


React.render <App />, document.getElementById 'container'
