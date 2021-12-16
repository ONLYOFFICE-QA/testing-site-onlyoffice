# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /banners.aspx
  # https://user-images.githubusercontent.com/18173785/29400808-57bbeeaa-8337-11e7-86f8-c4223588a3c8.png
  class SiteNonProfitBanners
    include PageObject

    span(:switcher_125x125, xpath: '(//*[contains(@class,"switcher")]/*[@data-group="125x125"]/*)[1]')
    span(:switcher_250x250, xpath: '(//*[contains(@class,"switcher")]/*[@data-group="250x250"]/*)[1]')
    span(:switcher_468x60, xpath: '(//*[contains(@class,"switcher")]/*[@data-group="468x60"]/*)[1]')
    span(:switcher_728x90, xpath: '(//*[contains(@class,"switcher")]/*[@data-group="728x90"]/*)[1]')
    span(:switcher_160x600, xpath: '(//*[contains(@class,"switcher")]/*[@data-group="160x600"]/*)[1]')

    text_area(:banner_code,
              xpath: '//div[contains(@class, "size-group active")]/div[contains(@class, "whole")]/textarea')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(switcher_125x125_element)
      end
    end

    def switch_banner_to_size_works?(size_to_switch = :size_125x125)
      @instance.webdriver.click_on_locator banners[size_to_switch][:xpath]
      wait_to_load
      banner_code.include? banners[size_to_switch][:valid_value]
    end

    def banners
      {
        size_125x125: {
          xpath: switcher_125x125_element.selector[:xpath],
          valid_value: '125-x-125'
        },
        size_250x250: {
          xpath: switcher_250x250_element.selector[:xpath],
          valid_value: '250-x-250'
        },
        size_468x60: {
          xpath: switcher_468x60_element.selector[:xpath],
          valid_value: '468-x-60'
        },
        size_728x90: {
          xpath: switcher_728x90_element.selector[:xpath],
          valid_value: '728-x-90'
        },
        size_160x600: {
          xpath: switcher_160x600_element.selector[:xpath],
          valid_value: '160-x-600'
        }
      }
    end
  end
end
