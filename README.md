# [Budget Tracker](https://budget-tracker-rails.herokuapp.com/) - ⚠ WIP ⚠

A simple budget tracker using Rails.

### To run locally

Dependencies:

- Ruby v. 2.5.1
- Bundler gem
- Postgresql

```bash
git clone https://github.com/steviekaye/budget-tracker.git
cd budget-tracker
bundle install
sudo -u postgres createuser -s budget-tracker
bundle exec rake db:create:all
rake db:migrate
rake db:seed
rails server
```

And browse to `localhost:3000`
