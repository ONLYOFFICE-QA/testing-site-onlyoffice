# frozen_string_literal: true

module TestingSiteOnlyoffice
  # https://helpcenter.onlyoffice.com/faq/faq.aspx
  # https://user-images.githubusercontent.com/40513035/103107863-93c01100-4653-11eb-9931-86b122a0d680.png
  class SiteFaq
    include PageObject

    div(:faq_indicator, xpath: '//a[contains(@class, "leftmenu_f_a_q selected")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(faq_indicator_element) }
    end
  end
end
