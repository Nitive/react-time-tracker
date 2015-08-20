'use strict'
React = require 'react/addons'
randomColor = require 'randomcolor'
JsonCircular = require 'json-circular'

Starter = require './starter.coffee'
TimersList = require './timers-list.coffee'


App = React.createClass

	getInitialState: ->
		data = JsonCircular.parse localStorage.state or '{}'
		data ||= {}
		timers: data.timers or []
		tasks: data.tasks or {}


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
		unless @state.tasks[task]
			return -1

		time = 0
		for timer in @state.timers
			if timer.task.name is task
				time += (timer.stopTime or Date.now()) - timer.startTime
		time


	getTaskMoney: (task) ->
		console.log 'getTaskMoney'


	getTaskColor: (taskName) ->
		color = randomColor luminosity: 'light'
		(@state.tasks[taskName] or color: color).color


	addTimer: (taskName, taskColor, taskRate) ->
		task = @addTask taskName, taskColor, taskRate

		timer =
			id: do Math.random
			task: task
			played: yes
			startTime: Date.now()

		timers = React.addons.update @state.timers, {}
		for t in timers
			t.played = no
			t.stopTime ||= Date.now()

		timers.unshift timer
		@setState timers: timers


	stopTimer: ->
		timers = React.addons.update @state.timers, {}
		timers[0].played = no
		timers[0].stopTime = Date.now()
		@setState timers: timers


	tickTimer: ->
		@setState timers: @state.timers


	changeTimerName: (oldTaskName, newTaskName, taskRate, timer) ->
		task = React.addons.update @state.tasks[oldTaskName], {}
		task.name = newTaskName
		task.color = @getTaskColor newTaskName
		timer.task = task

		newTasks = {}
		newTasks[newTaskName] = task
		newTasks = React.addons.update @state.tasks, $merge: newTasks
		@setState tasks: newTasks


	destroyTimer: (timer) ->
		timers = @state.timers.filter (item) -> item.id isnt timer.id
		@setState timers: timers


	componentDidUpdate: ->
		localStorage.state = JsonCircular.stringify @state


	render: ->
		<div>
			<header className='header'>React Time Tracker</header>
			<Starter
				addTimer=@addTimer
				getTaskColor=@getTaskColor
			/>
			<TimersList
				timers=@state.timers
				stopTimer=@stopTimer
				getTaskTime=@getTaskTime
				tick=@tickTimer
				addTimer=@addTimer
				changeTimerName=@changeTimerName
				getTaskColor=@getTaskColor
				destroyTimer=@destroyTimer
				/>
		</div>


React.render <App />, document.getElementById 'container'
