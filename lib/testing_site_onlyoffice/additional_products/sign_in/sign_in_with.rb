# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Sign in with network
  class SignInWith
    attr_accessor :instance

    include PageObject

    element(:google_indicator, xpath: "//div[contains(text(),'Google')]")
    element(:facebook_indicator, xpath: "//form[contains(@action, 'facebook')]")
    element(:twitter_indicator, xpath: "//form[@id = 'oauth_form']")
    element(:linkedin_indicator, xpath: "(//*[@type='linkedin-logo'])[1]/../../form[@class='login__form']")

    def initialize(instance, network)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load(network)
    end

    def wait_to_load(network)
      @instance.webdriver.wait_until do
        indicator_element_present?(network)
      end
    end

    def indicator_element_present?(network)
      case network
      when :google
        @instance.webdriver.element_present?(google_indicator_element)
      when :facebook
        @instance.webdriver.element_present?(facebook_indicator_element)
      when :twitter
        @instance.webdriver.element_present?(twitter_indicator_element)
      when :linkedin
        @instance.webdriver.element_present?(linkedin_indicator_element)
      end
    end
  end
end
