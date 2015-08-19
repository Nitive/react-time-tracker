'use strict'
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
				className='starter__color-picker'
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



List = React.createClass

	render: ->
		<ul>
			{
				@props.timers.map (timer, i) ->
					<li key={i}>{timer.task.name}</li>
			}
		</ul>



App = React.createClass

	# Добавить задачу, если её еще нет
	addTask: (name, color) ->
		task = null

		unless @state.tasks[name]
			task =
				name: name
				color: color
			newTasks = {}
			newTasks[name] = task
			newTasks = React.addons.update @state.tasks, $merge: newTasks
			@setState tasks: newTasks

		task or @state.tasks[name]


	getTaskTime: (task) ->
		console.log 'getTaskTime'


	getTaskMoney: (task) ->
		console.log 'getTaskMoney'


	startTimer: (timer) ->
		timer.played = yes
		timer.startTime = Date.now()


	stopTimer: (timer) ->
		timer.played = no
		timer.stopTime = Date.now()


	addTimer: (taskName, taskColor) ->
		task = @addTask taskName, taskColor

		timer = task: task
		@startTimer timer
		for t in @state.timers
			@stopTimer t

		@setState timers: React.addons.update @state.timers, $push: [timer]


	getInitialState: ->
		data = JSON.parse localStorage.state or '{}'
		data ||= {}
		timers: data.timers or []
		tasks: data.tasks or {}


	componentDidUpdate: ->
		localStorage.state = JSON.stringify @state


	render: ->
		<div>
			<header className='header'>React Time Tracker</header>
			<Starter
				addTimer=@addTimer
			/>
			<List timers=@state.timers />
		</div>


React.render <App />, document.getElementById 'container'
