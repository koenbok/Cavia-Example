### About
This is an example project for [Cavia](http://github.com/Cavia), a simple key value store on top of sql. It exposes a simple rest api over http. You can run it on your local machine or deploy it to Heroku.

### Example
	-> PUT /api/persons/5322a0046d7a050fc8b80cdb3b58796c '{name: "Koen Bok", age: 29}'
	-> GET /api/persons/5322a0046d7a050fc8b80cdb3b58796c
	<- {name: "Koen Bok", age: 29}
	-> GET /api/persons
	<- [{name: "Koen Bok", age: 29}]