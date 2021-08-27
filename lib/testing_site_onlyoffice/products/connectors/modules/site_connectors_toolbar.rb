# frozen_string_literal: true

require_relative '../../../get_onlyoffice/onlyoffice_docs/site_docs_enterprise'
require_relative '../site_products_connectors_onlyoffice'
require_relative '../site_products_connectors_partners'

module TestingSiteOnlyoffice
  # Site connectors top toolbar
  # https://user-images.githubusercontent.com/40513035/116348744-7e92f480-a7a3-11eb-9e56-a04ae6fd53d5.png
  module SiteConnectorsToolbar
    include PageObject

    link(:get_onlyoffice_docs, xpath: "//div[@class='contentConteiner']//a[@class='button gray']")
    div(:developed_by_onlyoffice, xpath: "//div[@id='own_downloads']")
    div(:provided_by_partners, xpath: "//div[@id='thirdparty_downloads']")

    def switch_to_developed_by_onlyoffice
      developed_by_onlyoffice_element.click
      SiteProductsConnectorsOnlyoffice.new(@instance)
    end

    def switch_to_provided_by_partners
      provided_by_partners_element.click
      SiteProductsConnectorsPartners.new(@instance)
    end

    def get_onlyoffice_docs
      get_onlyoffice_docs_element.click
      SiteDocsEnterprise.new(@instance)
    end
  end
end
