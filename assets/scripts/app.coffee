'use strict'
React = require 'react/addons'
randomColor = require 'randomcolor'
JsonCircular = require 'json-circular'

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
				timers: []
			newTasks = {}
			newTasks[name] = task
			newTasks = React.addons.update @state.tasks, $merge: newTasks
			@setState tasks: newTasks

		task or @state.tasks[name]


	getTaskTime: (task) ->
		unless @state.tasks[task]
			return -1

		time = 0
		for timer in @state.tasks[task].timers
			time += (timer.stopTime or Date.now()) - timer.startTime
		time


	getTaskMoney: (task) ->
		console.log 'getTaskMoney'


	addTimer: (taskName, taskColor, taskRate) ->
		task = @addTask taskName, taskColor, taskRate

		timer =
			id: do Math.random
			task: task
			played: yes
			startTime: Date.now()

		# изменяю @state.timers, чтобы не потерять ссылки на таймеры в @state.tasks
		timers = @state.timers
		for t in timers
			t.played = no
			t.stopTime ||= Date.now()

		timers.unshift timer
		task.timers.push timer
		@setState timers: timers


	stopTimer: ->
		# изменяю @state.timers, чтобы не потерять ссылки на таймеры в @state.tasks
		timers = @state.timers
		timers[0].played = no
		timers[0].stopTime = Date.now()
		@setState timers: timers


	tickTimer: ->
		@setState timers: @state.timers


	getInitialState: ->
		data = JsonCircular.parse localStorage.state or '{}'
		data ||= {}
		timers: data.timers or []
		tasks: data.tasks or {}


	componentDidUpdate: ->
		localStorage.state = JsonCircular.stringify @state


	render: ->
		<div>
			<header className='header'>React Time Tracker</header>
			<Starter
				addTimer=@addTimer
			/>
			<TimersList
				timers=@state.timers
				stopTimer=@stopTimer
				getTaskTime=@getTaskTime
				tick=@tickTimer
				/>
		</div>


React.render <App />, document.getElementById 'container'
