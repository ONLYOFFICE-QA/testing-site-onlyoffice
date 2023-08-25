# frozen_string_literal: true

require_relative '../modules/site_editors_xpath'

module TestingSiteOnlyoffice
  # /document-editor.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/53475320/98ec2a73-5f71-4b55-83ea-3b73c87ec9a3
  class SiteFeaturesDocumentEditor
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
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(docspace_registration_button_element) && @instance.webdriver.element_present?(documents_image_element) }
    end
  end
end
