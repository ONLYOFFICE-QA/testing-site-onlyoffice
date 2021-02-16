# /spreadsheet-editor.aspx
# https://user-images.githubusercontent.com/40513035/101172507-4f43e580-3652-11eb-8218-3b0f96dd55a9.png
require_relative '../modules/site_editors_xpath'

module TestingSiteOnlyffice
  class SiteProductsPresentationEditor
    include PageObject
    include SiteEditorsXpath
    include SiteToolbar

    div(:presentation_image, xpath: "//div[@class='oses_blocks_image pe']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { run_on_your_own_server_element.present? && presentation_image_element.present? }
    end
  end
end
