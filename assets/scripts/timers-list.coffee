React = require 'react/addons'
randomColor = require 'randomcolor'



Timer = React.createClass

	getInitialState: ->
		color: @props.timer.task.color
		taskName: @props.timer.task.name
		editing: no


	startEditing: ->
		@setState editing: yes


	finishEditing: ->
		@setState editing: no


	onChangeTaskName: (e) ->
		# TODO: update task in app.state.tasks
		@setState taskName: e.target.value


	changeColor: ->
		# TODO: update task in app.state.tasks
		@setState color: randomColor luminosity: 'light'


	togglePlayed: ->
		# TODO: toggle played state and update app.state.timers

	destroyTimer: ->
		# TODO: destroy timer, update app.state.timers and app.state.tasks


	generateTaskNode: ->
		if @state.editing
			<input
				className='timer__task'
				onBlur=@finishEditing
				value=@state.taskName
				onChange=@onChangeTaskName
				autoFocus
			/>
		else
			<span
				className='timer__task'
				onClick=@startEditing
			>{@state.taskName}</span>


	render: ->
		<li className='timer'>
			<div
				className='color-picker timer__color-picker'
				style={backgroundColor: @state.color}
				onClick=@changeColor
			/>
			<span className='timer__rate'>500</span>
			{do @generateTaskNode}
			<span className='timer__task-info'>
				<span className='timer__task-time'>20 ч 25 мин</span>
				<span className='timer__task-money'>11 275 ₽</span>
			</span>
			<span className='timer__data'>
				<span className='timer__period'>5 ч 37 мин</span>
				<span className='timer__time'>14:29:11 - 14:39:53</span>
			</span>
			<div
				className={if @props.timer.played then 'timer__play-btn' else 'timer__stop-btn'}
				onClick=@togglePlayed
			/>
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
					/>
			}
		</ul>



module.exports = TimersList
