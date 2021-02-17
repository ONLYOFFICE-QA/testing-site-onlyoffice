# Open source packages page
# https://user-images.githubusercontent.com/40513035/95976363-0e80da80-0e20-11eb-8a03-310fd68a4945.png

module TestingSiteOnlyoffice
  module SiteToolbarOpenSource
    include PageObject

    div(:open_source_onlyoffice_docs, xpath: '//div[@id="docs"]')
    div(:open_source_onlyoffice_groups, xpath: '//div[@id="groups"]')
    div(:open_source_bundles, xpath: '//div[@id="bundles" or @id="workspace"]')
    div(:open_source_connectors, xpath: '//div[@id="connectors"]')

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
  end
end
