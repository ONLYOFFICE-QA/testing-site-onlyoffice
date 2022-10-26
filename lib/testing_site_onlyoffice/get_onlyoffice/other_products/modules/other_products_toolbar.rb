# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Onlyoffice Other Products toolbar
  # https://user-images.githubusercontent.com/38238032/197996929-1f83497c-4acc-48fa-9c21-3f73b4c81000.png
  module SiteOtherProductsToolbar
    include PageObject

    div(:site_other_products_onlyoffice_groups, xpath: '//div[@id = "groups"]')
    div(:site_other_products_bundles, xpath: '//div[@id = "bundles"]')

    def site_other_products_onlyoffice_groups_download
      site_other_products_onlyoffice_groups_element.click
      SiteOtherProductsGroups.new(@instance)
    end

    def site_other_products_bundles_download
      site_other_products_bundles_element.click
      SiteOtherProductsBundles.new(@instance)
    end
  end
end
