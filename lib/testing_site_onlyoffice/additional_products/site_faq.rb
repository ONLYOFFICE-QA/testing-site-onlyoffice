# frozen_string_literal: true

# https://user-images.githubusercontent.com/40513035/103107863-93c01100-4653-11eb-9931-86b122a0d680.png

module TestingSiteOnlyoffice
  class SiteFaq
    include PageObject

    div(:faq_indicator, xpath: '//div[@class="faqpage general_faq"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { faq_indicator_element.present? }
    end
  end
end
