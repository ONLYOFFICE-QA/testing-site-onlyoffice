# Connectors
# https://user-images.githubusercontent.com/40513035/96696620-a25c2480-1393-11eb-9f6b-4abba59d41b5.png
require_relative '../../modules/site_toolbar'
require_relative 'modules/site_connectors_version_date'
require_relative 'modules/site_open_source_toolbar'
require_relative '../modules/site_download_helper'
require_relative 'site_connector_release_data'

module TestingSiteOnlyffice
  class SiteOpenSourceConnectors
    include PageObject
    include SiteConnectorsVersionDate
    include SiteDownloadHelper
    include SiteToolbar
    include SiteToolbarOpenSource

    link(:site_connectors_alfresco_github, xpath: '//a[@href = "https://github.com/ONLYOFFICE/onlyoffice-alfresco"]')
    link(:site_connectors_alfresco_instruction, xpath: '//a[contains(@href, "Alfresco.aspx")]')

    link(:site_connectors_confluence_github,
         xpath: '//a[@href = "https://github.com/ONLYOFFICE/onlyoffice-confluence"]')
    link(:site_connectors_confluence_instruction, xpath: '//a[contains(@href, "Confluence.aspx")]')

    link(:site_connectors_humhub_github, xpath: '//a[@href = "https://github.com/ONLYOFFICE/onlyoffice-humhub/"]')
    link(:site_connectors_humhub_instruction, xpath: '//a[contains(@href, "Humhub.aspx")]')

    link(:site_connectors_liferay_github, xpath: '//a[@href = "https://github.com/ONLYOFFICE/onlyoffice-liferay"]')
    link(:site_connectors_liferay_instruction, xpath: '//a[contains(@href, "Liferay.aspx")]')

    link(:site_connectors_nextcloud_github, xpath: '//a[@href = "https://github.com/ONLYOFFICE/onlyoffice-nextcloud"]')
    link(:site_connectors_nextcloud_instruction, xpath: '//a[contains(@href, "Nextcloud.aspx#overview")]')

    link(:site_connectors_nuxeo_github, xpath: '//a[@href = "https://github.com/ONLYOFFICE/onlyoffice-nuxeo"]')
    link(:site_connectors_nuxeo_instruction, xpath: '//a[contains(@href, "Nuxeo.aspx")]')

    link(:site_connectors_owncloud_github, xpath: '//a[@href = "https://github.com/ONLYOFFICE/onlyoffice-owncloud"]')
    link(:site_connectors_owncloud_instruction, xpath: '//a[contains(@href, "Owncloud.aspx#overview")]')

    link(:site_connectors_plone_github, xpath: '//a[@href = "https://github.com/ONLYOFFICE/onlyoffice-plone"]')
    link(:site_connectors_plone_instruction, xpath: '//a[contains(@href, "Plone.aspx")]')

    link(:site_connectors_sharepoint_github,
         xpath: '//a[@href = "https://github.com/ONLYOFFICE/onlyoffice-sharepoint"]')
    link(:site_connectors_sharepoint_instruction, xpath: '//a[contains(@href, "Sharepoint.aspx")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        site_connectors_alfresco_github_element.present?
      end
    end

    def download_links
      {
        alfresco: site_connectors_alfresco_github_element,
        confluence: site_connectors_confluence_github_element,
        humhub: site_connectors_humhub_github_element,
        liferay: site_connectors_liferay_github_element,
        nextcloud: site_connectors_nextcloud_github_element,
        nuxeo: site_connectors_nuxeo_github_element,
        owncloud: site_connectors_owncloud_github_element,
        plone: site_connectors_plone_github_element,
        sharepoint: site_connectors_sharepoint_github_element
      }
    end

    def instruction_links
      {
        alfresco: site_connectors_alfresco_instruction_element,
        confluence: site_connectors_confluence_instruction_element,
        humhub: site_connectors_humhub_instruction_element,
        liferay: site_connectors_liferay_instruction_element,
        nextcloud: site_connectors_nextcloud_instruction_element,
        nuxeo: site_connectors_nuxeo_instruction_element,
        owncloud: site_connectors_owncloud_instruction_element,
        plone: site_connectors_plone_instruction_element,
        sharepoint: site_connectors_sharepoint_instruction_element
      }
    end

    def get_on_github_connector(connector)
      download_links[connector].click
    end

    def read_instruction_connector(connector)
      instruction_links[connector].click
    end
  end
end
