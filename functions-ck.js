#functions the program does.

buildQuestion = () ->
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

