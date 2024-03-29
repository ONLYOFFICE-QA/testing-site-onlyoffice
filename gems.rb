# frozen_string_literal: true

source 'https://rubygems.org'
gem 'faker'
gem 'httparty'
gem 'json'
gem 'nokogiri'
gem 'onlyoffice_documentserver_testing_framework'
gem 'onlyoffice_file_helper'
gem 'onlyoffice_iredmail_helper'
gem 'onlyoffice_tcm_helper'
gem 'onlyoffice_testrail_wrapper'
gem 'onlyoffice_webdriver_wrapper', '>= 1.10.0'
gem 'page-object'
gem 'palladium'
gem 'rake'
gem 'rspec'
gem 'rspec_passed_time_formatter'
gem 'rspec-retry'
gem 'wrata_api'

group :development do
  gem 'overcommit', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', require: false
end
