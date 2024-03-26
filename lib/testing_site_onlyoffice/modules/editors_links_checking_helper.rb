# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for checking editors links
  module EditorsLinksCheckingHelper

    FEATURES_LINKS =
      {
        text_document_editing: {
          xpath: '//div[contains(@class, "ca_text")]/a[contains(@href, "document-editor.aspx")]',
          class: SiteFeaturesDocumentEditor
        },
        spreadsheet_editing: {
          xpath: '//div[contains(@class, "ca_text")]/a[contains(@href, "spreadsheet-editor.aspx")]',
          class: SiteFeaturesSpreadsheetEditor
        },
        digital_form_building: {
          xpath: '//div[contains(@class, "ca_text")]/a[contains(@href, "form-creator.aspx")]',
          class: SiteFeaturesFormCreator
        },
        presentation_editing: {
          xpath: '//div[contains(@class, "ca_text")]/a[contains(@href, "presentation-editor.aspx")]',
          class: SiteFeaturesPresentationEditor
        },
        pdf_editing_and_filling: {
          xpath: '//div[contains(@class, "ca_text")]/a[contains(@href, "pdf-editor")]',
          class: SiteFeaturesPDFReaderConverter
        },
        e_book_creation: {
          xpath: '//div[contains(@class, "ca_text")]/a[contains(@href, "e-book.aspx")]',
          class: SiteFeaturesEBookCreator
        },
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
