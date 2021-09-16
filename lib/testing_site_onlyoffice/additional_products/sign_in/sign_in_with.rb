# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Sign in with network
  class SignInWith
    attr_accessor :instance

    include PageObject

    element(:google_indicator, xpath: "(//a[contains(@href, 'google')])[1]/../../../..//input[@type='email']")
    element(:facebook_indicator, xpath: "//form[contains(@action, 'facebook')]")
    element(:twitter_indicator, xpath: "//form[contains(@action, 'twitter')]")
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
        google_indicator_element.present?
      when :facebook
        facebook_indicator_element.present?
      when :twitter
        twitter_indicator_element.present?
      when :linkedin
        linkedin_indicator_element.present?
      end
    end
  end
end
