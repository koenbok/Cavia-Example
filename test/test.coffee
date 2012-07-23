require "coffee-script"

async = 	require "async"
request = 	require "request"
utils =		require "./utils"

data =
	name: "Koen Bok"
	age: 29
	
addPerson = ->
	
	id = utils.uuid()

	request
		method: "PUT"
		# uri: "http://localhost:5000/api/persons/#{id}"
		uri: "http://salty-river-9212.herokuapp.com/api/persons/#{id}"
		body: data
		json: true
	, (error, response, body) ->
		throw error if error
		console.log id

async.map [0..1000], addPerson, ->
	console.log 'done'