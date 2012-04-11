# a list of all questions the program can ask
QUESTIONS = {}

QUESTIONS.password =
	text : 'Please enter your password:'
	validation : /.+/
	error : 'Your password must not be empty.'
	pre: ->
		INPUT.type = 'password'
	next: 'homeScreen'
	action : (input) ->
		INPUT.type = 'text'


QUESTIONS.logIn = 
	text : 'Please enter your email address:'
	validation : /.+@.+\..+/
	error : 'Must be a valid email address.'
	next : 'password'


QUESTIONS.nameSurvey =
	text: 'Enter a name for your survey:'
	validation : /.+/
	error : 'You must enter a name for your survey'
	next: 'editSurvey'

QUESTIONS.newQuestion =
	text : 'What kind of question do you want to add?'
	options : [
		{text: 'Text Input',
		next : 'QuestionTitle'
		action: -> DISPATCH.queue 'textInputOptions'
		},
		{text: 'Multiple Choice',
		next : 'QuestionTitle'
		action : -> DISPATCH.queue 'mcOptions'
		},
		{text: 'Checkbox',

			},
		{text: 'Descriptive Text'

		}
	]

QUESTIONS.homeScreen =
	text : 'What would you like to do?'
	options : [
		{ text: 'Create a new survey',
		next: 'nameSurvey'
		},
		{ text: 'View saved surveys',
		action: ->
			console.log 'viewing'
		}]

QUESTIONS.editSurvey =
	text : 'What would you like to do?'
	options : [
		{ text : 'Add a Question',
		next : 'newQuestion'
		}
	]
	action : ->
		#BUFFER.clear()

QUESTIONS.QuestionTitle =
	#Question title has no next key because it is used for each question type.
	#The next key is set by the question type option action.
	text : 'Enter your question:'

QUESTIONS.textInputOptions =
	text: 'Would you like to add any options to your text input question?'
	pre : ->
		DISPATCH.queue 'textInputOptions'
	options : [{
	text: 'Make textarea',
	action : () ->
		console.log 'make textarea'
		return true
	}]
	end : 'editSurvey'
	action : (x) ->
		if x == '0' or x == 'DONE'
			DISPATCH._queue.pop()
			buildTextQuestion()

QUESTIONS.mcOptions =
	text : 'What would you like to do next?'
	pre : -> DISPATCH.queue 'mcOptions'
	options : [
		{text: 'Add Choice',
		next:'addChoice'
		}]
	end : 'editSurvey'
	action : (x) ->
		if x == '0' or x == 'DONE'
			#get rid of the item we just added since we are done
			DISPATCH._queue.pop()
			buildMCQuestion()

QUESTIONS.addChoice =
	text : 'Enter name of choice:'


