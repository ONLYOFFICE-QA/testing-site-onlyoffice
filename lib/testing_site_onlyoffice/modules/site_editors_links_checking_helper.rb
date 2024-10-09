# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for checking editors links
  module SiteEditorsLinksCheckingHelper
    FEATURES_LINKS =
      {
        text_document_editing: {
          xpath: '(//a[contains(@href, "/document-editor.aspx")])[3]',
          class: SiteFeaturesDocumentEditor
        },
        spreadsheet_editing: {
          xpath: '(//a[contains(@href, "spreadsheet-editor.aspx")])[3]',
          class: SiteFeaturesSpreadsheetEditor
        },
        digital_form_building: {
          xpath: '(//a[contains(@href, "form-creator.aspx")])[3]',
          class: SiteFeaturesFormCreator
        },
        presentation_editing: {
          xpath: '(//a[contains(@href, "presentation-editor.aspx")])[3]',
          class: SiteFeaturesPresentationEditor
        },
        pdf_editing_and_filling: {
          xpath: '(//a[contains(@href, "pdf-editor")])[3]',
          class: SiteFeaturesPDFReaderConverter
        }
      }.freeze

    def click_link_by_feature(feature_key)
      feature_info = FEATURES_LINKS[feature_key]
      @instance.webdriver.move_to_element_by_locator(feature_info[:xpath])
      @instance.webdriver.click_on_locator(feature_info[:xpath])
      feature_info[:class].new(@instance)
    end
  end
end
