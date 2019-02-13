# [Budget Tracker](https://budget-tracker-rails.herokuapp.com/)

A simple budget tracker using Rails.

This was a "post-tutorial" project that began simply and slowly accumulated functionality.

- Refactoring and Git workflow
- Custom routing and controller logic
- Testing with RSpec
- Styling with Bulma and FontAwesome
- Simple charts using Chartkick, and creating service methods to format the data appropriately.

### Potential extensions:

- Using Devise to add users/logins.

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
