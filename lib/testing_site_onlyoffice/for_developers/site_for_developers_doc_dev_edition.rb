# frozen_string_literal: true

require_relative '../for_developers/site_for_developers_doc_builder'
require_relative '../for_developers/site_for_developers_conversion_api'
require_relative '../features/docs/site_features_e_book_creator'
require_relative '../modules/site_for_developers_dev_docs'

module TestingSiteOnlyoffice
  # developer-edition.aspx
  # https://user-images.githubusercontent.com/67409742/166101050-a8605bdb-d3be-4300-9376-cb57db77a93f.png
  class SiteForDevelopersDocDevEdition
    include PageObject
    include SiteDownloadHelper
    include SiteForDevelopersDevDocs

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?("//*[@id='get-it-now__developer-edition__b__download-docs']") }
    end

    def check_button_get_it_developer?
      xpath = "//div[@class='solutionspages_header_narrow']//a[contains(@href,'/download-docs.aspx')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def check_button_developer_see_in_action?
      xpath = "//div[@class='solutionspages_header_narrow']//a[@href='/see-it-in-action.aspx']"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteFeaturesSeeItInAction.new(@instance)
    end

    def click_button_macros_and_plugins
      xpath = "//a[contains(@href,'api.onlyoffice.com/plugin/basic')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
    end

    def check_button_cross_browser_compatibility?
      xpath = "//div[@class='sfb_gb_item block2']//a[contains(@href,'/document-editor-comparison.aspx')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteCompareSuites.new(@instance)
    end

    def check_button_easy_deployment?
      xpath = "//a[contains(@href,'/download-docs.aspx') and text() = 'Try now for free']"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def click_button_external_access
      xpath = "//a[contains(@href,'api.onlyoffice.com/editors/interactingoutside')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
    end

    def check_button_wopi_support?
      xpath = "//a[contains(@href,'/wopi-comparison.aspx')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteWOPIComparison.new(@instance)
    end

    def check_button_get_started_self_hosted?
      xpath = "//div[contains(@class, 'choice')]//a[@href='/download-docs.aspx']"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteGetOnlyofficeDocsDeveloper.new(@instance)
    end

    def click_button_get_started_amazone_machine
      xpath = "//a[contains(@href,'aws.amazon.com/marketplace')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
    end

    def click_button_get_started_alibaba_image
      xpath = "//a[contains(@href,'marketplace.alibabacloud.')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
    end
  end
end
