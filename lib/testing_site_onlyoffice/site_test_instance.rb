require_relative 'site_home_page'
require_relative '../../../Teamlab/Framework/TestInstance'

# Instance of browser to perform actions
module TestingSiteOnlyffice
  class SiteTestInstance
    attr_accessor :webdriver, :user, :headless, :doc_instance
    # @return [Hash] list of secret data
    attr_reader :secret_data
    alias driver webdriver
    alias selenium webdriver

    def initialize(user = AuthData.new, browser = :chrome)
      @user = user
      @secret_data = SecretData.new.decrypt
      @webdriver = WebDriver.new(browser, record_video: false)
      url = @user.portal.end_with?('//www.teamlab.info') ? "#{@user.portal}?Site_Testing=4testing" : @user.portal
      @webdriver.open(url)
    end

    def init_online_documents
      @doc_instance = TestInstanceDocs.new(@user, use_community_server_api: false)
      raise 'Cannot init online documents, because browser was not initialized' if @webdriver.driver.nil?

      @doc_instance.selenium = @webdriver
    end
  end
end
