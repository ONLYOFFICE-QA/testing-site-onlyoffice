# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for storing additional methods of the class SiteForDevelopersDocDevEdition
  module SiteDocDevEditionHelper
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

    def click_document_builder
      xpath = "//a[@class='link' and contains(@href, 'document-builder.aspx')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteForDevelopersDocBuilder.new(@instance)
    end

    def click_document_conversion
      xpath = "//a[@class='link' and contains(@href, 'conversion-api.aspx')]"
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteForDevelopersConversionAPI.new(@instance)
    end
  end
end
