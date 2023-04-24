# frozen_string_literal: true

module TestingSiteOnlyoffice
  # docs-cloud.aspx
  # https://user-images.githubusercontent.com/67409742/166878450-e00614be-5e32-4f72-9c56-ca121a540dcb.png
  class SiteProductsCloudEdition
    include PageObject

    div(:cloud_edition, xpath: "//div[@id='docs-cloud']")
    link(:document_editing, xpath: "//div[@class='itb-point']//a[@href='/document-editor.aspx']")
    link(:spreadsheet_editing, xpath: "//div[@class='itb-point']//a[@href='/spreadsheet-editor.aspx']")
    link(:presentation_editing, xpath: "//div[@class='itb-point']//a[@href='/presentation-editor.aspx']")
    link(:form_creator, xpath: "//div[@class='itb-point']//a[@href='/form-creator.aspx']")
    link(:pre_order, xpath: "//div[@class='first-screen-content']//a[@href='/docs-registration.aspx']")
    link(:other_connectors, xpath: "//div[@class='ctb-item ready-connectors']//a[@href='/all-connectors.aspx']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(cloud_edition_element) }
    end

    def check_button_spreadsheet_editing?
      spreadsheet_editing_element.click
      SiteFeaturesSpreadsheetEditor.new(@instance)
    end

    def check_button_presentation_editing?
      presentation_editing_element.click
      SiteFeaturesPresentationEditor.new(@instance)
    end

    def check_button_document_editing?
      document_editing_element.click
      SiteFeaturesDocumentEditor.new(@instance)
    end

    def check_button_form_creator?
      form_creator_element.click
      SiteFeaturesFormCreator.new(@instance)
    end

    def check_button_pre_order?
      pre_order_element.click
      DocsRegistrationPage.new(@instance)
    end

    def check_button_other_connectors?
      other_connectors_element.click
      SiteFeaturesConnectorsOnlyoffice.new(@instance)
    end
  end
end
