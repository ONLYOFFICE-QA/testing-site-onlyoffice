# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Unsubscribe confirmation page
  # https://user-images.githubusercontent.com/40513035/136525586-a3ee4e5d-b879-48d2-88bc-4a650b2dd3f0.png
  class SiteUnsubscribeConfirmation
    include PageObject

    link(:news_resubscribe, xpath: '//a[@id = "resubscribe_mm"]')
    div(:successful_resubscribe, xpath: '//div[@class="mm_resub"]//div[@class = "success_logo"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { resubscribe_button_present? }
    end

    def resubscribe_button_present?
      news_resubscribe_element.present?
    end

    def successful_resubscribe_present?
      successful_resubscribe_element.present?
    end

    def news_resubscribe
      news_resubscribe_element.click
      @instance.webdriver.wait_until { successful_resubscribe_present? }
    end
  end
end
