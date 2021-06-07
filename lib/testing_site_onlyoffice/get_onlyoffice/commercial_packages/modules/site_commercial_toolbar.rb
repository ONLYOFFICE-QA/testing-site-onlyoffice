# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Commercial Packages top toolbar
  # https://user-images.githubusercontent.com/40513035/96172632-60645600-0f2f-11eb-8853-b6c348e7235d.png
  module SiteToolbarCommercial
    include PageObject

    div(:site_commercial_docs, xpath: '//div[@id = "docs-enterprise"]')
    div(:site_commercial_workspace, xpath: '//div[@id="bundles" or @id="workspace"]')

    def open_commercial_docs
      site_commercial_docs_element.click
      SiteCommercialDocs.new(@instance)
    end

    def open_commercial_workspace
      site_commercial_workspace_element.click
      SiteCommercialWorkspace.new(@instance)
    end
  end
end
