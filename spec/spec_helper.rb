require_relative '../lib/testing_site_onlyoffice'
require_relative '../shared_examples/commercial_installer_download'
require_relative '../shared_examples/document_builder_download'
require 'onlyoffice_testrail_wrapper'
require 'rspec'

# @return [TestingApiOnlyfficeCom::Config] config of test run
def config
  @config ||= TestingApiOnlyfficeCom::Config.new
end
