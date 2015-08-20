'use strict'
React = require 'react/addons'
randomColor = require 'randomcolor'

Starter = require './starter.coffee'
TimersList = require './timers-list.coffee'


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

		timer =
			id: do Math.random
			task: task
		@startTimer timer
		for t in @state.timers
			@stopTimer t

		@setState timers: React.addons.update @state.timers, $unshift: [timer]


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
			<TimersList timers=@state.timers />
		</div>


React.render <App />, document.getElementById 'container'
