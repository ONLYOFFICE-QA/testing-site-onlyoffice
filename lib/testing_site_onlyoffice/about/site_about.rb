# frozen_string_literal: true

require_relative '../modules/site_toolbar'
module TestingSiteOnlyoffice
  # /about.aspx
  # https://user-images.githubusercontent.com/40513035/101415041-44aa7a00-38f8-11eb-858b-8c1f89115293.png
  class SiteAbout
    include PageObject
    include SiteToolbar

    div(:about_page, xpath: '//div[@class="wwd_header_narrow max-width-1"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { about_page_element.present? }
    end

    def opened?
      @instance.webdriver.driver.current_url.include? '/about.aspx'
    end
  end
end
