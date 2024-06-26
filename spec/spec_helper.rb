# frozen_string_literal: true

require_relative '../lib/testing_site_onlyoffice'
require_relative '../shared_examples/commercial_installer_download'
require_relative '../shared_examples/desktop_installer_download'
require_relative '../shared_examples/document_builder_download'
require_relative '../shared_examples/integration_pick_price'
require_relative '../shared_examples/connector_download'
require_relative '../shared_examples/checking_logger_errors'
require_relative '../shared_examples/pricing_buy_page'
require_relative '../shared_examples/checking_editors_links'
require_relative '../shared_examples/check_sla_and_privacy_links'
require_relative '../lib/testing_site_onlyoffice/gem_overrides/mail_override'
require 'onlyoffice_testrail_wrapper'
require 'rspec'
require 'rspec/retry'

# @return [TestingApiOnlyfficeCom::Config] config of test run
def config
  @config ||= TestingApiOnlyfficeCom::Config.new
end

RSpec.configure do |config|
  is_debug = OnlyofficeFileHelper::RubyHelper.debug?
  config.default_retry_count = if is_debug
                                 1
                               else
                                 2
                               end
  config.verbose_retry = true
end
