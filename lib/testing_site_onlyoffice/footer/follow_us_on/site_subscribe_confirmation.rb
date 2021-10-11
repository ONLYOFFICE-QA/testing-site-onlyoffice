# frozen_string_literal: true

require_relative 'site_unsubscribe_confirmation'

module TestingSiteOnlyoffice
  # Go to link in mail for confirm subscribe
  # https://user-images.githubusercontent.com/40513035/136717045-3533baea-d7c1-413e-a0a3-0b127865a7d0.png
  class SiteSubscribeConfirmation
    include PageObject

    link(:news_unsubscribe, xpath: '//a[contains(@href, "Unsubscribe")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      wait_success_text_visible?
    end

    def wait_success_text_visible?
      @instance.webdriver.element_present?("//div[@class='description']/p[contains(text(), 'successfully subscribed')]") ||
        @instance.webdriver.element_present?("//*[@id='subscribepage']//h1[contains(text(), 'Thank you for subscribing')]")
    end

    def news_unsubscribe
      news_unsubscribe_element.click
      SiteUnsubscribeConfirmation.new(@instance)
    end
  end
end
