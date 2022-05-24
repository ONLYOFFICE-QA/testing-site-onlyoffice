# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Site footer developers
  module SiteFooterDevelopers
    include PageObject

    link(:document_builder, xpath: '//a[@href="/document-builder.aspx"]')

    def click_document_builder_info
      document_builder_element.click
      SiteDocumentBuilder.new(@instance)
    end
  end
end
