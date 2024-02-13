# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Get download, install, release date, verson and what's new xpath for open source connector block
  # https://user-images.githubusercontent.com/40513035/112917085-cba57d00-90b6-11eb-8191-1de6102afadb.png
  class SiteConnectorsConstructor
    attr_accessor :instance, :get_on_github_xpath, :instruction_xpath, :whats_new_xpath, :version_xpath, :release_date_xpath

    include PageObject

    def initialize(instance, installer)
      super(instance.webdriver.driver)
      @instance = instance
      @installer = installer
      @get_on_github_xpath = "//a[@id='#{installer}_button']"
      @instruction_xpath = "(#{@get_on_github_xpath}/../..//a)[2]"
      @whats_new_xpath = "#{@get_on_github_xpath}/../..//a[contains(@href,'CHANGELOG')]"
      @version_xpath = "#{@get_on_github_xpath}/../../div/p[1]"
      @release_date_xpath = "#{@get_on_github_xpath}/../../div/p[2]"
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(@get_on_github_xpath)
      end
    end
  end
end
