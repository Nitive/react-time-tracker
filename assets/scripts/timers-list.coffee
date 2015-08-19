React = require 'react/addons'



Timer = React.createClass

	render: ->
		<li key={@props.key}>{@props.timer.task.name}</li>



TimersList = React.createClass

	render: ->
		<ul>
			{
				@props.timers.map (timer, i) ->
					<Timer key={i} timer={timer} />
			}
		</ul>



module.exports = TimersList
