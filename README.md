# README

This README would normally document whatever steps are necessary to get the
application up and running.



# What has been implemented
1. Build a simple rails banking app.
2. Via the console you can create users with password.
3. The user must be able to log in.
4. Via the console you can give the user credit.
5. User has a bank account with balance.
6. Users can transfer money to each other.
7. Users may not have a negative balance on their account.
8. It must be traceable how a user obtained a certain balance.
9. It is important that money cannot just disappear or appear into account.

# Technical details (packages and style guide followed)

* ```Ruby 2.7.3 and Rails 6```
* ```DEVISE``` for user authentication 
* ```Bootstrap 5``` for frontend design

### Check out the repository
```git clone https://github.com/pro-dev-azan/solera-test-project.git```

Things you may want to cover:
* RVM
Make sure you have following required packages installed:
  * ```curl```
  * ```gpg2```

And then run:

```\curl -sSL https://get.rvm.io | bash -s stable```

* Ruby version

```rvm install ruby-2.7.3```

* System dependencies

```gem install rails```

* Configuration

```bundle install```

```brew install yarn```

```yarn add bootstrap```

* Database creation

```rails db:setup```

* Database initialization

```rails db:migrate```


### Start the app

You're ready to localize your app:

```rails server```

Run ```rails c``` then ```user = User.create(email: 'example@abcd.com', password: '123123')```
Also, add some balance in user's account ```user.back_account.update(balance: 1000)```

Using above creds signin on ```localhost:3000``` 
