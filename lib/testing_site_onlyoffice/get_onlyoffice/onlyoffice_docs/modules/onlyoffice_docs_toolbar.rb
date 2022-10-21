# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Onlyoffice Docs top toolbar
  # https://user-images.githubusercontent.com/40513035/131134452-5ac3e85b-e369-4269-b8eb-8248f5a370ac.png
  module SiteToolbarOnlyofficeDocs
    include PageObject

    div(:site_docs_enterprise, xpath: '//div[@id = "docs-enterprise"]')
    div(:site_docs_developer, xpath: '//div[@id = "docs-developer"]')
    div(:site_docs_community, xpath: '//div[@id = "docs-community"]')

    def site_docs_enterprise_download
      site_docs_enterprise_element.click
      SiteGetOnlyofficeDocsEnterprise.new(@instance)
    end

    def site_docs_developer_download
      site_docs_developer_element.click
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def site_docs_community_download
      site_docs_community_element.click
      SiteDocsCommunity.new(@instance)
    end
  end
end
