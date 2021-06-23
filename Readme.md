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

## How to update secret config

1. `rake decrypt_secret_config`
2. Edit `lib/testing_site_onlyoffice/data/private_data/data.yml` via any text editor
3. `rake update_secret_config`
4. Add `lib/testing_site_onlyoffice/data/private_data/data.yml.gpg` to VCS

**Important** Never add decrypted
  `lib/testing_site_onlyoffice/data/private_data/data.yml` to VCS. 
  This file is in `.gitignore` and should never be committed
