# frozen_string_literal: true

require_relative 'site_for_business_docs_enterprise_edition'

module TestingSiteOnlyoffice
  # for-enterprises.aspx
  # https://user-images.githubusercontent.com/38238032/233962616-6ebf0024-1da6-4335-91cf-77ae686e6317.jpg
  class SiteEnterprise
    include PageObject

    link(:docspace_link, xpath: '//a[@href = "/docspace.aspx?from=for-enterprises"]')
    link(:docs_enterprise_link, xpath: '//a[@href = "/docs-enterprise.aspx?from=for-enterprises"]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(docspace_link_element) }
    end

    def open_docs_enterprise
      docs_enterprise_link.click
      SiteForBusinessDocsEnterpriseEdition.new(@instance)
    end
  end
end
