# frozen_string_literal: true

require_relative '../modules/site_toolbar'
module TestingSiteOnlyoffice
  # /press-downloads.aspx
  # https://user-images.githubusercontent.com/67409742/145952088-087b405c-94fb-43b8-bdcf-7d03b767b968.png
  class SiteAboutPressDownloads
    include PageObject
    div(:press_downloads_page, xpath: '//div[@class="InnerPage pressdownloadspage"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { press_downloads_page_element.present? }
    end

    def left_menu_xpath
      '//ul[@class="pdm_menu"]/li/a'
    end

    def left_menu_count
      @instance.webdriver.get_element_count(left_menu_xpath)
    end

    def left_menu_list
      (1..left_menu_count).map do |index|
        element_xpath = "(#{left_menu_xpath})[#{index}]"
        @instance.webdriver.get_text(element_xpath)
      end
    end
  end
end
