# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for checking editors links
  module SiteEditorsLinksCheckingHelper

    FEATURES_LINKS =
      {
        text_document_editing: {
          xpath: '(//a[contains(@href, "/document-editor.aspx")])[1]',
          class: SiteFeaturesDocumentEditor
        },
        spreadsheet_editing: {
          xpath: '(//a[contains(@href, "spreadsheet-editor.aspx")])[1]',
          class: SiteFeaturesSpreadsheetEditor
        },
        digital_form_building: {
          xpath: '(//a[contains(@href, "form-creator.aspx")])[1]',
          class: SiteFeaturesFormCreator
        },
        presentation_editing: {
          xpath: '(//a[contains(@href, "presentation-editor.aspx")])[1]',
          class: SiteFeaturesPresentationEditor
        },
        pdf_editing_and_filling: {
          xpath: '(//a[contains(@href, "pdf-editor")])[1]',
          class: SiteFeaturesPDFReaderConverter
        },
        e_book_creation: {
          xpath: '(//a[contains(@href, "e-book.aspx")])[1]',
          class: SiteFeaturesEBookCreator
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
