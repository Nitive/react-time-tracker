'use strict'
React = require 'react/addons'
randomColor = require 'randomcolor'

Starter = require './starter.coffee'
TimersList = require './timers-list.coffee'


App = React.createClass

	# Добавить задачу, если её еще нет
	addTask: (name, color, rate) ->
		task = null

		unless @state.tasks[name]
			task =
				name: name
				color: color
				rate: rate or 0
			newTasks = {}
			newTasks[name] = task
			newTasks = React.addons.update @state.tasks, $merge: newTasks
			@setState tasks: newTasks

		task or @state.tasks[name]


	getTaskTime: (task) ->
		console.log 'getTaskTime'


	getTaskMoney: (task) ->
		console.log 'getTaskMoney'


	addTimer: (taskName, taskColor, taskRate) ->
		task = @addTask taskName, taskColor, taskRate

		timer =
			id: do Math.random
			task: task
			played: yes
			startTime: Date.now()

		newTimers = []
		newTimers.push timer
		for t in @state.timers
			newTimers.push React.addons.update t,
				played: $set: no
				stopTime: $set: Date.now()

		@setState timers: newTimers


	stopTimer: ->
		newTimers = React.addons.update @state.timers, {}
		newTimers[0].played = no
		newTimers[0].stopTime = Date.now()
		@setState timers: newTimers


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
			<TimersList
				timers=@state.timers
				stopTimer=@stopTimer
				/>
		</div>


React.render <App />, document.getElementById 'container'
