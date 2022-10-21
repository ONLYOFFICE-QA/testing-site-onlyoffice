# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Onlyoffice Other Products toolbar
  # https://user-images.githubusercontent.com/40513035/131134177-324fc225-63b7-491e-8899-2b895f4fe324.png
  module SiteOtherProductsToolbar
    include PageObject

    div(:site_other_products_connectors, xpath: '//div[@id = "connectors"]')
    div(:site_other_products_onlyoffice_groups, xpath: '//div[@id = "groups"]')
    div(:site_other_products_bundles, xpath: '//div[@id = "bundles"]')
    div(:site_other_products_document_builder, xpath: '//div[@id = "builder"]')

    def site_other_products_connectors_download  # ?
      site_other_products_connectors_element.click
      SiteGetOnlyofficeConnectors.new(@instance)
    end

    def site_other_products_onlyoffice_groups_download
      site_other_products_onlyoffice_groups_element.click
      SiteOtherProductsGroups.new(@instance)
    end

    def site_other_products_bundles_download
      site_other_products_bundles_element.click
      SiteOtherProductsBundles.new(@instance)
    end

    def site_other_products_document_builder_download # ?
      site_other_products_document_builder_element.click
      SiteGetOnlyofficeDownloadDocBuilder.new(@instance)
    end
  end
end
