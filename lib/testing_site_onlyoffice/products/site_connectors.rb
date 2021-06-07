# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /all-connectors.aspx
  # https://user-images.githubusercontent.com/40513035/100945721-d9853000-3512-11eb-97e9-9880b0264f9d.png
  class SiteConnectors
    include PageObject

    own_downloads_root = '//div[@class="integration_own_downloads"]'
    link(:alfresco_connector, xpath: "#{own_downloads_root}//a[contains(@href, '/office-for-alfresco.aspx')]")
    link(:confluence_connector, xpath: "#{own_downloads_root}//a[contains(@href, '/office-for-confluence.aspx')]")
    link(:humhub_connector, xpath: "#{own_downloads_root}//a[contains(@href, '/office-for-humhub.aspx')]")
    link(:liferay_connector, xpath: "#{own_downloads_root}//a[contains(@href, '/office-for-liferay.aspx')]")
    link(:nextcloud_connector, xpath: "#{own_downloads_root}//a[contains(@href, '/office-for-nextcloud.aspx')]")
    link(:nuxeo_connector, xpath: "#{own_downloads_root}//a[contains(@href, '/office-for-nuxeo.aspx')]")
    link(:owncloud_connector, xpath: "#{own_downloads_root}//a[contains(@href, '/office-for-owncloud.aspx')]")
    link(:plone_connector, xpath: "#{own_downloads_root}//a[contains(@href, '/office-for-plone.aspx')]")
    link(:sharepoint_connector, xpath: "#{own_downloads_root}//a[contains(@href, '/office-for-sharepoint.aspx')]")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { sharepoint_connector_element.present? }
    end

    def click_sharepoint_connector
      @instance.webdriver.click_on_locator sharepoint_connector_xpath
      SiteConnectorSharepoint.new(@instance)
    end

    def click_nextcloud_connector
      @instance.webdriver.click_on_locator nextcloud_connector_xpath
      SiteConnectorNextcloud.new(@instance)
    end

    def click_owncloud_connector
      @instance.webdriver.click_on_locator owncloud_connector_xpath
      SiteConnectorOwncloud.new(@instance)
    end

    def click_alfresco_connector
      @instance.webdriver.click_on_locator alfresco_connector_xpath
      SiteConnectorAlfresco.new(@instance)
    end

    def click_confluence_connector
      @instance.webdriver.click_on_locator confluence_connector_xpath
      SiteConnectorConfluence.new(@instance)
    end
  end
end
