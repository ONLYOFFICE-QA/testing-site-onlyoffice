# /document-editor.aspx
# https://user-images.githubusercontent.com/40513035/101095370-e10a0f00-35ce-11eb-94df-968041d32462.png
require_relative '../modules/site_editors_xpath'

module TestingSiteOnlyoffice
  class SiteProductsDocumentEditor
    include PageObject
    include SiteEditorsXpath
    include SiteToolbar

    div(:documents_image, xpath: "//div[@class='oses_blocks_image doc']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { run_on_your_own_server_element.present? && documents_image_element.present? }
    end
  end
end
