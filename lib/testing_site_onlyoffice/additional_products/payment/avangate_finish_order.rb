# frozen_string_literal: true

module TestingSiteOnlyoffice
  class AvangateFinishOrder
    attr_accessor :instance

    include PageObject

    text_field(:place_order, xpath: '//input[@id="AuthorizeButton"]')
    div(:place_order_loader, xpath: '//div[contains(@class, "page-preloader")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      review_and_place_order
      @instance.webdriver.wait_until do
        @instance.webdriver.driver.current_url.include?('/order/finish')
      end
    end

    def review_and_place_order
      return if @instance.webdriver.driver.current_url.include?('/order/finish')
      return unless place_order_element.present?

      @instance.webdriver.wait_until do
        !place_order_loader_element.present?
      end

      place_order_element.click
    end
  end
end
