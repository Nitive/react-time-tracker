React = require 'react/addons'
randomColor = require 'randomcolor'

Starter = React.createClass

	getInitialState: ->
		value: ''
		color: randomColor luminosity: 'light'


	onChange: (e) ->
		@setState value: e.target.value
		# do @changeColor


	changeColor: ->
		@setState color: randomColor luminosity: 'light'


	addTimer: (e) ->
		do e.preventDefault
		@props.addTimer @state.value, @state.color
		@setState value: ''
		do @changeColor


	render: ->
		<div className='starter'>
			<div
				style={backgroundColor: @state.color}
				className='color-picker starter__color-picker'
				onClick=@changeColor
			/>
			<form onSubmit=@addTimer>
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


module.exports = Starter