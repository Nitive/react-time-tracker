React = require 'react'



UndoPanel = React.createClass
	render: ->
		<div className='undo-panel'>
			<span className='undo-panel__text'>{@props.undoMessage}</span>
			<input
				className='undo-panel__submit'
				type='submit'
				value='Отменить'
				onClick=@props.restoreTimer
			/>
		</div>

module.exports = UndoPanel
