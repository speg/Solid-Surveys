'use strict'
INPUT = document.getElementById 'input'
QUESTION = document.getElementById 'question'
OPTIONS = document.getElementById 'options'
ANSWER = document.getElementById 'answer'
ERROR = document.getElementById 'error'
Q = {}

DISPATCH =
	_queue : []
	queue : (x) ->
		@_queue.push x
	next : -> @_queue.shift()


BUFFER =
	buffer : []
	chain : []
	description : 'nothing'
	length : () -> @buffer.length
	push : (x) -> @buffer.push x
	clear : ->
		@buffer = []
		@chain = []
	print : () ->
		console.log '*** BUFFER ***'
		console.log @description
		console.log @chain
		console.log @buffer
		console.log DISPATCH._queue

input.focus()

renderQuestion = (question) ->
	if Q.options
		delete Q.next
	Q = question
	BUFFER.chain.push question
	if Q.pre
		Q.pre()
	QUESTION.innerHTML = question.text
	if question.options
		OPTIONS.innerHTML = renderOptions question.options
	else
		OPTIONS.innerHTML = ''

	if question.end
		OPTIONS.innerHTML += ' 0 - Done'
	INPUT.value = ''
	INPUT.focus()

renderOptions = (options) ->
	s = ''
	i = 1
	for x in options
		s += '' + i + '. ' + x.text + ' '
		i += 1
	return s

success = () ->
	#process valid input
	r = INPUT.value
	INPUT.value = ''
	BUFFER.push r
	next = Q.next
	action = Q.action
	
	if arguments[0]
		next = Q.options[arguments[0]-1].next || Q.next || null
		action = Q.options[arguments[0]-1].action || Q.action || null

	if arguments[0] == 0
		#done a loop
		next = Q.end

	if action
		action r
	#BUFFER.print()
	renderQuestion QUESTIONS[next || DISPATCH.next()]


processInput = (e) ->
	ERROR.innerHTML = ''
	if e.keyCode == 13
		if Q.validation
			if Q.validation.test INPUT.value
				success()
			else
				ERROR.innerHTML = Q.error || 'Invalid input. Please try again.'
		else
			#no validation, process input
			success()

	else if Q.end && (INPUT.value == '0' || INPUT.value.toUpperCase() == 'DONE')
		success(0)

	else if Q.options
		if /[0-9]/.test(INPUT.value) && parseInt(INPUT.value, 10) <= Q.options.length
			o = parseInt INPUT.value, 10
			success(o)	
		else 
			ERROR.innerHTML = Q.error || ('Please enter a number 1 - ' + Q.options.length)
		

INPUT.addEventListener 'keyup', (e) -> processInput e
document.addEventListener 'click', () -> INPUT.focus()

renderQuestion(QUESTIONS.editSurvey)