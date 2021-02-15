# frozen_string_literal: true

module TestingSiteOnlyffice
  class AvangateFinishOrder
    attr_accessor :instance

    include PageObject

    link(:avangate_finish_order_page_link, xpath: "//*[@id='order__finish__finish__order']")
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

    def avangate_finish_order_page_visible?
      avangate_finish_order_page_link_element.present?
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
