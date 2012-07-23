require "coffee-script"

util = 		require "util"
log = 		require "winston"
express = 	require "express"
Resource = 	require "express-resource"
{gzip} =	require "connect-gzip"

cavia =		require "cavia"
{RestResource} = require "./resource"


# Configuration
config =
	dsn: process.env.DATABASE_URL
	port: process.env.PORT or 5000
	backend:
		log: true
		timeout: 60 * 10


# Define some models with indexes
models = 
	person:
		indexes:
			name: 	["string", (data) -> data.name]
			age: 	["int", (data) -> data.age]
	product:
		indexes:
			name: 	["string", (data) -> data.name]
			price: 	["int", (data) -> data.price]


# Set up the backend and connect the resources


if not config.dsn
	backend = new cavia.backends.SQLiteBackend "/tmp/test.sqlite3"
else
	log.info "Connecting to '#{config.dsn}'"
	backend = new cavia.backends.PostgresBackend config.dsn
	
store = new cavia.Store backend, models

backend.log = config.backend.log
backend.config.timeout = config.backend.timeout


# Build the server
app = express.createServer()
app.use express.bodyParser()
app.use gzip()

app.resource "api/persons", new RestResource store, "person", "person"
app.resource "api/products", new RestResource store, "product", "product"

store.create ->
	app.listen config.port, ->
		log.info "Listening on #{config.port}"