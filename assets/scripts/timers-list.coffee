React = require 'react/addons'
randomColor = require 'randomcolor'



Timer = React.createClass

	getInitialState: ->
		@timer = setInterval @tick, 50

		color: @props.timer.task.color
		name: @props.timer.task.name
		rate: @props.timer.task.rate
		editing: no


	startEditing: ->
		@setState editing: yes


	finishEditing: ->
		@setState editing: no


	onChangeTaskName: (e) ->
		# TODO: update task in app.state.tasks
		@setState name: e.target.value


	changeColor: ->
		# TODO: update task in app.state.tasks
		@setState color: randomColor luminosity: 'light'


	stopTimer: ->
		# TODO: stop timer
		do @props.stopTimer

	restartTimer: ->
		@props.addTimer @state.name, @state.color, @state.rate
		# TODO: restart timer


	destroyTimer: ->
		# TODO: destroy timer, update app.state.timers and app.state.tasks


	tick: ->
		if @props.timer.stopTime
			return clearInterval @timer
		do @props.tick


	componentWillUnmount: ->
		clearInterval @timer


	generateTaskNode: ->
		if @state.editing
			<input
				className='timer__task'
				onBlur=@finishEditing
				value=@state.name
				onChange=@onChangeTaskName
				autoFocus
			/>
		else
			<span
				className='timer__task'
				onClick=@startEditing
			>{@state.name}</span>


	render: ->
		<li className='timer'>
			<div
				className='color-picker timer__color-picker'
				style={backgroundColor: @state.color}
				onClick=@changeColor
			/>
			<span className='timer__rate'>{@state.rate}</span>
			{do @generateTaskNode}
			<span className='timer__task-info'>
				<span className='timer__task-time'>
					{@props.getTaskTime @props.timer.task.name}
				</span>
				<span className='timer__task-money'>11 275 ₽</span>
			</span>
			<span className='timer__data'>
				<span className='timer__period'>
					{(@props.timer.stopTime or Date.now()) - @props.timer.startTime}
				</span>
				<span className='timer__time'>
					{@props.timer.startTime} - {@props.timer.stopTime or Date.now()}
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
					/>
			}
		</ul>



module.exports = TimersList
