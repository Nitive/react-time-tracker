React = require 'react/addons'
randomColor = require 'randomcolor'

Starter = React.createClass

	getInitialState: ->
		value: ''
		color: randomColor luminosity: 'light'
		rate: 0


	onChange: (e) ->
		@setState value: e.target.value
		@changeColor e.target.value
		@changeRate e.target.value


	onChangeRate: (e) ->
		@setState rate: Number e.target.value.replace /\D+/g, ''


	changeColor: (taskName) ->
		@setState color: @props.getTaskColor taskName


	changeRate: (taskName) ->
		rate = @props.getTaskRate taskName
		@setState rate: if rate is -1 then @state.rate else rate


	addTimer: (e) ->
		do e.preventDefault
		@props.addTimer @state.value, @state.color, @state.rate
		do @changeColor
		@setState
			value: ''
			rate: 0



	render: ->
		<div className='starter'>
			<div
				style={backgroundColor: @state.color}
				className='color-picker starter__color-picker'
				onClick=@changeColor
			/>
			<form onSubmit=@addTimer>
				<input
					placeholder='Чем вы заниматетесь?'
					className='starter__input'
					value=@state.value
					onChange=@onChange
					tabIndex=0
					autoFocus
					/>
				<input
					className='starter__submit'
					value='Старт'
					type='submit'
					tabIndex=1
				/>
				<div className='starter__rate'>
					Ставка:
					<input
					onChange=@onChangeRate
					value=@state.rate
					tabIndex=0
					/>
					руб/ч
				</div>
			</form>
		</div>


module.exports = Starter
