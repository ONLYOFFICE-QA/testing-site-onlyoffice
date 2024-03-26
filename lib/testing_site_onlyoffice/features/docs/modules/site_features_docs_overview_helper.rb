# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for storing additional methods of the class SiteFeaturesDocsOverview
  # Contains methods for working with the "choose where to work" block.
  module SiteFeaturesDocsOverviewHelper

    def click_docspace_start_free
      xpath = '//*[@id="office_suite_docspace_registration_start_with_your_free_account"]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteDocSpaceSignUp.new(@instance)
    end

    def click_ready_integrations
      xpath = '//div[contains(@class, "sb_text")]/a[contains(@href, "all-connectors.aspx")]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteConnectorsOnlyoffice.new(@instance)
    end

    def click_get_docs_now
      xpath = '//*[@id="office_suite_download_docs_get_it_now"]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteGetOnlyofficeDocsEnterprise.new(@instance)
    end

    def click_integrate_learn_more
      xpath = '//*[@id="office_suite_download_docs_de_get_it_now"]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteForDevelopersDocDevEdition.new(@instance)
    end
  end
end
