[![build status](https://travis-ci.org/matiasleidemer/my_api.svg)](https://travis-ci.org/matiasleidemer/my_api)
[![Code Climate](https://codeclimate.com/github/matiasleidemer/my_api/badges/gpa.svg)](https://codeclimate.com/github/matiasleidemer/my_api)

## my_api

This is a simple rails app to illustrate a simple restful api

### Gems used

- _CanCanCan_ for authorization;
- _Rspec_ for testing;
- _jbuilder_ for json response;
- _faker_ for generating random data;

### Set up

- run `bundle` to install the dependencies;
- run `bundle exec rake db:setup` to set up the database. It'll also add some registers using the seeds file;

### Running

After the setting everything, you only need to start the rails server:

```
bundle exec rails s -p3000
```

This will start a new rails server on port 3000. The current available restful endpoints are:

- localhost:3000/api/v1/articles
- localhost:3000/api/v1/articles/:article_id/comments

### Roles

There are currently 3 access roles:

- Admin: can manage all data;
- User: can read and create everything, but only update it's registers;
- Guest: can only read data;

### Authentication

Basic http authentication is used. Running `bundle exec rake db:setup` will create an Admin and a User. In order to authenticate you need to fill the user name and password with the user's email and password.

Guest users can be authenticated with both username and password 'guest'

### Tests

Run `bundle exec rspec` or `bundle exec rake`.

### Copyright

Copyright (c) 2015 Matias H. Leidemer. See LICENSE.txt for further details.
