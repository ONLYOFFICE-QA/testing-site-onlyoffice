# frozen_string_literal: true

require_relative '../modules/site_toolbar'
module TestingSiteOnlyoffice
  # /onlyoffice.myspreadshop.com
  # https://user-images.githubusercontent.com/67409742/158983083-7378567f-34e7-4396-8c28-2aec2b36e223.png
  class SiteAboutGiftShop
    include PageObject

    button(:button_shop_now, xpath: '//button[contains(@class,"sprd-btn-primary")]')
    element(:shop_list, xpath: '//main[@class="sprd-product-list"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(button_shop_now_element) }
      name_button == 'Shop Now'
    end

    def name_button
      @instance.webdriver.get_text(button_shop_now_element)
    end

    def go_to_shop_now
      button_shop_now_element.click
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(shop_list_element) }
    end
  end
end
