# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Open source packages page
  # https://user-images.githubusercontent.com/40513035/110755741-58001500-825a-11eb-9356-7a99013a9b69.png
  module SiteToolbarOpenSource
    include PageObject

    div(:open_source_onlyoffice_docs, xpath: '//div[@id="docs"]')
    div(:open_source_onlyoffice_groups, xpath: '//div[@id="groups"]')
    div(:open_source_bundles, xpath: '//div[@id="bundles" or @id="workspace"]')
    div(:open_source_connectors, xpath: '//div[@id="connectors"]')
    div(:open_source_document_builder, xpath: '//div[@id="builder"]')

    def open_opensource_onlyoffice_docs
      open_source_onlyoffice_docs_element.click
      SiteOpenSourceDocs.new(@instance)
    end

    def open_opensource_connectors
      open_source_connectors_element.click
      SiteOpenSourceConnectors.new(@instance)
    end

    def open_opensource_bundles
      open_source_bundles_element.click
      SiteOpenSourceBundles.new(@instance)
    end

    def open_opensource_groups
      open_source_onlyoffice_groups_element.click
      SiteOpenSourceGroups.new(@instance)
    end

    def open_opensource_document_builder
      open_source_document_builder_element.click
      SiteOpenSourceDocumentBuilder.new(@instance)
    end
  end
end
