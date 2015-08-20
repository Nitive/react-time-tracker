React = require 'react/addons'
randomColor = require 'randomcolor'
format = require './timeformat.coffee'



Timer = React.createClass

	getInitialState: ->
		@timer = setInterval @tick, 50
		name: @props.timer.task.name
		rate: @props.timer.task.rate
		editing: no


	onChangeTaskName: (e) ->
		@setState
			name: e.target.value
			color: @props.getTaskColor e.target.value
		@props.changeTimerName @state.name, e.target.value, @props.getTaskRate(@state.name), @props.timer


	changeColor: ->
		@props.setTask @state.name, randomColor luminosity: 'light'


	onChangeTaskRate: (e) ->
		@props.setTask @state.name, null, Number e.target.value.replace /\D+/g, ''


	stopTimer: ->
		do @props.stopTimer


	restartTimer: ->
		@props.addTimer @state.name, @props.getTaskColor @state.name, @props.getTaskRate @state.name


	destroyTimer: ->
		@props.destroyTimer @props.timer


	tick: ->
		if @props.timer.stopTime
			return clearInterval @timer
		do @props.tick


	componentWillUnmount: ->
		clearInterval @timer


	render: ->
		timerDuration = (@props.timer.stopTime or Date.now()) - @props.timer.startTime
		taskDuration = @props.getTaskTime @state.name

		<li className='timer'>
			<div
				className='color-picker timer__color-picker'
				style={backgroundColor: @props.getTaskColor @state.name}
				onClick=@changeColor
			/>
			<span className='timer__rate'>
				<input
					value={@props.getTaskRate @state.name}
					onChange=@onChangeTaskRate
				/>
			</span>

			<input
				className='timer__task'
				onBlur=@finishEditing
				value=@state.name
				onChange=@onChangeTaskName
			/>

			<span className='timer__task-info'>
				<span className='timer__task-time'>
					{format.duration taskDuration}
				</span>
				<span className='timer__task-money'>
					{Math.round @props.getTaskRate(@state.name) * taskDuration / (1000 * 60 * 60)} ₽
					</span>
			</span>

			<span className='timer__data'>
				<span className='timer__period'>
					{format.duration timerDuration}
				</span>
				<span className='timer__time'>
					{format.time @props.timer.startTime} - {format.time @props.timer.stopTime or Date.now()}
				</span>

			</span>
			{
				if @props.timer.played
					<div
						className='timer__stop-btn'
						onClick=@stopTimer
					/>
				else
					<div
						className='timer__play-btn'
						onClick=@restartTimer
					/>
			}
			<div
				className='timer__delete-btn'
				onClick=@destroyTimer
			>×</div>
		</li>



TimersList = React.createClass

	render: ->
		<ul className='timers-list'>
			{
				@props.timers.map (timer, i) =>
					<Timer
						key=timer.id
						timer=timer
						timers=@props.timers
						stopTimer=@props.stopTimer
						getTaskTime=@props.getTaskTime
						tick=@props.tick
						addTimer=@props.addTimer
						changeTimerName=@props.changeTimerName
						getTaskColor=@props.getTaskColor
						destroyTimer=@props.destroyTimer
						getTaskRate=@props.getTaskRate
						setTask=@props.setTask
					/>
			}
		</ul>



module.exports = TimersList
