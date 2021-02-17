# /spreadsheet-editor.aspx
# https://user-images.githubusercontent.com/40513035/101167017-4d762400-364a-11eb-9590-d80819942f57.png
require_relative '../modules/site_editors_xpath'

module TestingSiteOnlyoffice
  class SiteProductsSpreadsheetEditor
    include PageObject
    include SiteEditorsXpath
    include SiteToolbar

    div(:spreadsheet_image, xpath: "//div[@class='oses_blocks_image se']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { run_on_your_own_server_element.present? && spreadsheet_image_element.present? }
    end
  end
end
