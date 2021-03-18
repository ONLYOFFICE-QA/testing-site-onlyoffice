# frozen_string_literal: true

source 'https://rubygems.org'
gem 'activesupport'
gem 'clipboard'
gem 'csv'
gem 'droplet_kit'
gem 'faye-websocket'
gem 'httparty'
gem 'humanize'
gem 'icalendar'
gem 'json'
gem 'mail'
gem 'mechanize'
gem 'onlyoffice_api'
gem 'onlyoffice_documentserver_conversion_helper'
gem 'onlyoffice_documentserver_testing_framework', git: 'https://github.com/onlyoffice-testing-robot/onlyoffice_documentserver_testing_framework'
gem 'onlyoffice_file_helper'
gem 'onlyoffice_gmail_helper'
gem 'onlyoffice_iredmail_helper'
gem 'onlyoffice_language_helper'
gem 'onlyoffice_mysql_helper'
gem 'onlyoffice_pdf_parser'
gem 'onlyoffice_tcm_helper'
gem 'onlyoffice_testrail_wrapper'
gem 'onlyoffice_webdriver_wrapper'
gem 'ooxml_parser'
gem 'page-object'
gem 'palladium'
gem 'rake'
gem 'rspec'
gem 'rspec_passed_time_formatter'
gem 'rspec-retry'
gem 'wrata_api'
gem 'yard'

group :development do
  gem 'overcommit', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
end
