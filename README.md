# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
When heroku run rails db:migrate, Postgres Connection:Bad Error Solving.....
"GitHub Process Steps"

1. $git init

2. $git remote add origin https://github.com/your_organization_name/your_repository_name.git

3. $git add .

4. $git commit -m "Started"

5. $git push -u origin master


"Heroku Process Steps"

1. $heroku login 

2. $heroku git:remote -a your_app_name

3. $git add .

4. $git commit -m "Started"

5. $git push heroku master

6. $heroku run rails db:migrate

7. $heroku open

When PostgreSQL Error....
- heroku pg:info
- 1) heroku addons:create heroku-postgresql
- 2) heroku config --app your_app_name
- 3) heroku run rails db:migrate