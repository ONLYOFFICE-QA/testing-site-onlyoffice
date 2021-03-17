require_relative 'site_home_page'
require_relative 'test_manger/test_manager'

# Instance of browser to perform actions
module TestingSiteOnlyoffice
  class SiteTestInstance
    attr_accessor :webdriver, :doc_instance
    # @return [Hash] list of secret data
    attr_reader :secret_data
    alias driver webdriver
    alias selenium webdriver

    def initialize(config)
      @secret_data = SecretData.new.decrypt
      @webdriver = WebDriver.new(config.browser, record_video: false)
      url = config.server.end_with?('teamlab.info') ? "#{config.server}?Site_Testing=4testing" : config.server
      @webdriver.open(url)
    end

    def init_online_documents
      @doc_instance = TestInstanceDocs.new(AuthData.new, use_community_server_api: false)
      raise 'Cannot init online documents, because browser was not initialized' if @webdriver.driver.nil?

      @doc_instance.selenium = @webdriver
    end

    # @return [Hash] private data of site
    def private_data
      @private_data ||= SitePrivateData.new.decrypt
    end
  end
end
