React = require 'react/addons'
randomColor = require 'randomcolor'

Starter = React.createClass

	getInitialState: ->
		value: ''
		color: randomColor luminosity: 'light'
		rate: 0


	onChange: (e) ->
		@setState value: e.target.value
		@changeColor e


	onChangeRate: (e) ->
		@setState rate: Number e.target.value.replace /\D+/g, ''


	changeColor: (e) ->
		@setState color: @props.getTaskColor e.target.value


	addTimer: (e) ->
		do e.preventDefault
		@props.addTimer @state.value, @state.color, @state.rate
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
			<div className='starter__rate'>
				Ставка: <input onChange=@onChangeRate value=@state.rate /> ₽/ч
			</div>
		</div>


module.exports = Starter
