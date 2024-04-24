# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper for storing methods of the class SiteFeaturesDocsOverview
  module SiteDocSpaceMainPageHelper
    def click_registration_button
      docspace_registration_button_element.click
      SiteDocSpaceSignUp.new(@instance)
    end

    def click_zoom_collaboration_learn_more
      xpath = '//a[@class = "ds-ta-link" and @href = "/office-for-zoom.aspx"]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteConnectorsZoom.new(@instance)
    end

    def click_security_learn_more
      xpath = '//a[@class = "lm_link" and @href = "/security.aspx"]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteFeaturesSecurity.new(@instance)
    end

    def click_free_cloud_startups
      startups_free_cloud_element.click
      SiteDocSpaceSignUp.new(@instance)
    end

    def click_business_check_prices
      business_check_prices_element.click
      SitePricingDocSpacePrices.new(@instance)
    end

    def click_enterprise_get_it_now
      enterprise_get_it_now_element.click
      SiteDocSpaceDownloadEnterprise.new(@instance)
    end

    def click_docspace_start_free_cloud
      xpath = '//a[@id = "docspace_docspace_registration_start_with_your_free_account"]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteDocSpaceSignUp.new(@instance)
    end

    def click_deploy_on_your_own_server
      xpath = '//a[@id = "docspace_docspace_deploy_your_own_server"]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteDocSpaceDownloadEnterprise.new(@instance)
    end

    def click_connectors_get_it_now
      xpath = '//a[@id = "docspace_docspace_get_it_now"]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteConnectorsOnlyoffice.new(@instance)
    end

    def click_download_pc_now
      xpath = '//a[@id = "docspace_download_desktop_download_now"]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteGetOnlyofficeDesktopApps.new(@instance)
    end

    def click_mobile_install_now
      xpath = '//a[@id = "docspace_download_desktop_mobile_install_now"]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteMobileApps.new(@instance)
    end
  end
end
