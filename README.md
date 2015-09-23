## my_api

This is a simple rails app to illustrate a simple restful api

### Gems used

- _Devise_ for authentication;
- _CanCanCan_ for authorization;
- _Rspec_ for testing;
- _simple_token_authentication_ for token authentication;
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

_Devise_ and _simple_token_authentication_ are used for authentication. Running `bundle exec rake db:setup` will create an Admin and a User. In order to authenticate you need to pass the `user_email` and the `user_token` params along with the request. Example:

```
curl \
--data "article%5Bbody%5D=Article+body&article%5Btitle%5D=Article+Title&article%5Buser_id%5D=1" \
-X POST \
http://localhost:3000/api/v1/articles?user_email=user@company.com&user_token=kixCHzTycqt2vP5Py-ky
```

This will create a new article. If the `user_email` and `user_token` don't get passed (or don't match with the database) the access will be unauthorized. Guest users don't need to authenticate.

### Tests

Run `bundle exec rspec` or `bundle exec rake`.

### Copyright

Copyright (c) 2015 Matias H. Leidemer. See LICENSE.txt for further details.
