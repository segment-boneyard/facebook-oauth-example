# Facebook OAuth Example

This is an example Facebook OAuth flow implementation. It's useful if you want
to generate access tokens for testing the Facebook API or want an example when
implementing the OAuth flow in your application.

## Config

- CLIENT_ID
- CLIENT_SECRET

These should be set in your shell or a `.env` file in the root of this project.

`http://localhost:4567/` must also be whitelisted as a redirect domain in your
Facebook app settings.

## Usage

```sh
bundle install
bundle exec ruby app.rb
open http://localhost:4567/
```

## Credits

Inspired by [fliptepper]'s [facebook-oauth-example][original].

[fliptepper]: [https://github.com/fiptepper]
[original]: https://github.com/filiptepper/facebook-oauth-example
