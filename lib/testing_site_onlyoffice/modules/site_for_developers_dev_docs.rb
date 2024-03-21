# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for checking feature blocks links
  module SiteForDevelopersDevDocs

    FEATURES_LINKS =
      {
        text_document_editing: {
          xpath: "//a[@class='link' and contains(@href, 'document-editor')]",
          class: SiteFeaturesDocumentEditor
        },
        spreadsheet_editing: {
          xpath: "//a[@class='link' and contains(@href, 'spreadsheet-editor')]",
          class: SiteFeaturesSpreadsheetEditor
        },
        digital_form_building: {
          xpath: "//a[@class='link' and contains(@href, 'form-creator.aspx')]",
          class: SiteFeaturesFormCreator
        },
        presentation_editing: {
          xpath: "//a[@class='link' and contains(@href, 'presentation-editor.aspx')]",
          class: SiteFeaturesPresentationEditor
        },
        pdf_editing_and_filling: {
          xpath: "//a[@class='link' and contains(@href, 'pdf-editor.aspx')]",
          class: SiteFeaturesPDFReaderConverter
        },
        e_book_creation: {
          xpath: "//a[@class='link' and contains(@href, 'e-book.aspx')]",
          class: SiteFeaturesEBookCreator
        },
        document_building: {
          xpath: "//a[@class='link' and contains(@href, 'document-builder.aspx')]",
          class: SiteForDevelopersDocBuilder
        },
        document_conversion: {
          xpath: "//a[@class='link' and contains(@href, 'conversion-api.aspx')]",
          class: SiteForDevelopersConversionAPI
        }
      }.freeze

    def click_link_by_feature(feature_key)
      feature_info = FEATURES_LINKS[feature_key]
      @instance.webdriver.move_to_element_by_locator(feature_info[:xpath])
      @instance.webdriver.wait_until { @instance.webdriver.element_visible?(feature_info[:xpath]) }
      @instance.webdriver.click_on_locator(feature_info[:xpath])
      feature_info[:class].new(@instance)
    end
  end
end
