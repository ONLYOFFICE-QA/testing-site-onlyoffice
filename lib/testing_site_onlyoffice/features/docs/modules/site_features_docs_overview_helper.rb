# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for storing additional methods of the class SiteFeaturesDocsOverview
  module SiteFeaturesDocsOverviewHelper
    def click_get_it_now_top
      @instance.webdriver.click_on_locator(get_it_now_top_element)
      SiteGetOnlyofficeDocsEnterprise.new(@instance)
    end

    def click_see_it_action
      @instance.webdriver.click_on_locator(see_it_in_action_element)
      SiteFeaturesSeeItInAction.new(@instance)
    end

    def click_find_the_plugins
      xpath = '//a[contains(@href, "app-directory") and contains(@class, "ca_link")]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteFeaturesMarketplace.new(@instance)
    end

    def click_security_learn_more
      xpath = '//a[contains(@href, "security.aspx") and contains(@class, "lm-link")]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteFeaturesSecurity.new(@instance)
    end

    def click_download_pc
      xpath = '//div[contains(@class, "sb_from_pc")]'
      @instance.webdriver.click_on_locator(xpath)
      SiteGetOnlyofficeDesktopApps.new(@instance)
    end

    def click_install_mobile
      xpath = '//div[contains(@class, "sb_from_mobile")]'
      @instance.webdriver.click_on_locator(xpath)
      SiteMobileApps.new(@instance)
    end

    def click_docspace_start_free
      xpath = '//div[contains(@class, "sb_docspace")]'
      @instance.webdriver.click_on_locator(xpath)
      SiteDocSpaceSignUp.new(@instance)
    end

    def click_ready_integrations
      xpath = '//div[contains(@class, "sb_connectors")]'
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
      xpath = '//div[contains(@class, "sb_developers")]'
      @instance.webdriver.click_on_locator(xpath)
      SiteForDevelopersDocDevEdition.new(@instance)
    end
  end
end
