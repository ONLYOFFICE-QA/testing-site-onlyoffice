# frozen_string_literal: true

require_relative 'modules/site_connectors_toolbar'
require_relative 'site_connectors_constructor'
require_relative 'site_connectors_more_info'
require_relative '../../get_onlyoffice/modules/site_block_constructor_helper'
require_relative '../../get_onlyoffice/modules/site_download_helper'
require_relative '../../site_home_page'

module TestingSiteOnlyoffice
  # /all-connectors.aspx for developed by onlyoffice
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/e519cfa4-eb11-4c5a-b321-761276fce00f
  class SiteConnectorsOnlyoffice
    include PageObject
    include SiteConnectorsToolbar
    include SiteBlockConstructorHelper
    include SiteDownloadHelper
    include SiteToolbar
    divs(:connectors_block, xpath: "//div[@data-dev='oo_devs']//div[@class='itdn_section_description']")
    divs(:connectors_partners_block, xpath: "//div[@data-dev='partners_devs']//div[@class='itdn_section_description']")

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        chamilo_get_it_now_xpath = onlyoffice_connector_block.get_it_now_xpath
        @instance.webdriver.element_present?(chamilo_get_it_now_xpath)
      end
    end

    def onlyoffice_connector_block(connector = :chamilo)
      block_xpath = "//div[contains(@class, 'itdn_block') and @data-dev='oo_devs']"
      SiteProductsConnectorConstructor.new(@instance, block_xpath, connector.to_s)
    end

    def connectors_partners_block(connector = :chamilo)
      partners_block_xpath = "//div[contains(@class, 'itdn_block') and @data-dev='partners_devs']"
      SiteProductsConnectorConstructor.new(@instance, partners_block_xpath, connector.to_s)
    end

    def click_on_filter
      filter_xpath = "//*[@id = 'item-selector']"
      @instance.webdriver.wait_until_element_visible(filter_xpath)
      @instance.webdriver.click_on_locator(filter_xpath)
    end

    def click_on_developer_option
      developer_option_xpath = "//div[@id='by_developers']"
      @instance.webdriver.wait_until_element_visible(developer_option_xpath)
      @instance.webdriver.click_on_locator(developer_option_xpath)
    end

    def select_onlyoffice_developers
      click_on_filter
      click_on_developer_option
      onlyoffice_developers_xpath = "//li[@id='oo_devs']"
      @instance.webdriver.wait_until_element_visible(onlyoffice_developers_xpath)
      @instance.webdriver.click_on_locator(onlyoffice_developers_xpath)
    end

    def select_partners_developers
      click_on_filter
      click_on_developer_option
      partners_developers_xpath = "//li[@id='partners_devs']"
      @instance.webdriver.wait_until_element_visible(partners_developers_xpath)
      @instance.webdriver.get_element(partners_developers_xpath).click
    end

    def click_get_it_now_link(xpath)
      @instance.webdriver.click_on_locator(xpath)
    end

    def click_more_info_link(xpath, connector)
      @instance.webdriver.get_element(xpath).click
      SiteConnectorsMoreInfo.new(@instance, connector)
    end

    def click_partners_more_info_link(xpath)
      @instance.webdriver.get_element(xpath).click
    end

    def click_developers_site_link(xpath)
      @instance.webdriver.get_element(xpath).click
    end

    def get_connector_info_link(xpath)
      @instance.webdriver.get_attribute(xpath, 'href')
    end

    def connectors_block_number(developer_type)
      developer_type == :onlyoffice ? connectors_block_elements.count : connectors_partners_block_elements.count
    end

    def verify_elements_hidden(filter_option)
      xpath = if filter_option == :onlyoffice
                "//div[@data-dev='oo_devs']//div[@class='itdn_section_description']"
              elsif filter_option == :partners
                "//div[@data-dev='partners_devs']//div[@class='itdn_section_description']"
              end
      @instance.webdriver.wait_until { @instance.webdriver.get_element_count(xpath, true).zero? }
    end

    def onlyoffice_opened?
      @instance.webdriver.choose_tab(2)
      SiteHomePage.new(@instance)
    end
  end
end
