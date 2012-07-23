
all: deploy

deploy:
	git commit -a -m 'update'
	git push heroku master

provision:
	heroku login
	heroku create
	heroku addons:add heroku-postgresql:dev
	heroku pg:wait `heroku pg | grep '=== HEROKU_POSTGRESQL' | cut -d' ' -f 2`
	heroku pg:promote `heroku pg | grep '=== HEROKU_POSTGRESQL' | cut -d' ' -f 2`
	echo "Heroku provisioned. Deploy with 'make deploy'"

.PHONY: deploy provision