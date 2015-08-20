duration = (duration) ->
	s_coef = 1000
	m_coef = s_coef * 60
	h_coef = m_coef * 60

	hours = Math.floor duration / h_coef
	mins = Math.floor (duration - hours * h_coef) / m_coef
	secs = Math.floor (duration - mins * m_coef) / s_coef

	switch
		when hours
			"#{hours} ч #{mins} мин"
		when mins
			"#{mins} мин #{secs} с"
		else
			"#{secs} сек"

time = (time) ->
	date = new Date(time)
	"#{date.getHours()}:#{date.getMinutes()}:#{date.getSeconds()}"


module.exports =
	duration: duration
	time: time

