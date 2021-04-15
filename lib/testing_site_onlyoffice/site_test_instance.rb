require_relative 'site_home_page'
require_relative 'portal_helper/site_portal_creation_data'
require_relative 'teamlab_fail_notifier'
require_relative 'test_manger/test_manager'

require 'bundler/setup'
require 'active_support'
require 'httparty'
require 'faker'
require 'nokogiri'
require 'onlyoffice_documentserver_testing_framework'
require 'onlyoffice_iredmail_helper'
require 'onlyoffice_file_helper'
require 'onlyoffice_testrail_wrapper'
require 'onlyoffice_webdriver_wrapper'
require 'onlyoffice_tcm_helper'
require 'palladium'

include OnlyofficeDocumentserverTestingFramework
include OnlyofficeFileHelper
include OnlyofficeIredmailHelper
include OnlyofficeTestrailWrapper
include OnlyofficeWebdriverWrapper

# Instance of browser to perform actions
module TestingSiteOnlyoffice
  class SiteTestInstance
    attr_accessor :webdriver, :doc_instance
    alias driver webdriver
    alias selenium webdriver

    def initialize(config)
      @webdriver = WebDriver.new(config.browser, record_video: false)
      url = config.server.end_with?('teamlab.info') ? "#{config.server}?Site_Testing=4testing" : config.server
      @webdriver.open(url)
    end

    def init_online_documents
      @doc_instance = TestInstanceDocs.new(webdriver: @webdriver)
      raise 'Cannot init online documents, because browser was not initialized' if @webdriver.driver.nil?

      @doc_instance.selenium = @webdriver
    end

    # @return [Hash] private data of site
    def private_data
      @private_data ||= SitePrivateData.new.decrypt
    end
  end
end
