# Onlyoffice site testing

This project tests Onlyoffice site: <https://www.onlyoffice.com/>

## How to run tests

In order to execute tests use following commands:

Locally

1. `bundle install` Bundler will install all needed gems
2. `rspec spec/functional/spec_file.rb`

Remotely

1. Login to your [wrata](<https://github.com/ONLYOFFICE/testing-wrata>) instance
with user `Site`
2. Obtain API key and use it via terminal
3. `rake wrata:run_site_tests`
