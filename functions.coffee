#functions the program does.

buildTextQuestion = () ->
	console.log 'Building Question...'
	BUFFER.print()
	i = 0
	for x in BUFFER.chain
		console.log x.text, BUFFER.buffer[i]
		i += 1

	#runs through the buffer collecting inputs and builds the question:
	b = BUFFER.buffer
	switch b.shift()
		when '1' then type = 'text'
		when '2' then type = 'mc'
		when '3' then type = 'checkbox'
		else type = false

	return false if not type

	title = b.shift()

	for option in b
		if option > 0
			#add option
			a = 2

	console.log 'Making a ', type, ' question titled: ',title



	return true

buildMCQuestion = () ->
	console.log 'Building MC Question'
	b = BUFFER.buffer
	#confirm MC question type
	if b.shift() != '2'
		return false

	#next item will be the question title
	title = b.shift()

	console.log 'Question title:', title
	#debugger
	choices = []
	y = 0
	for x in b
		switch x
			when '1' then y = 1
			when '0' then y = 0
			else
				switch y
					when 1 then choices.push x
	console.log 'choices', choices




