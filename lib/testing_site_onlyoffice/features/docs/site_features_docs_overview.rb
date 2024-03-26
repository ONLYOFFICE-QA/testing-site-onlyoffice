# frozen_string_literal: true

require_relative '../site_features_marketplace'
require_relative '../../modules/site_editors_links_checking_helper'

module TestingSiteOnlyoffice
  # /office-suite.aspx
  # https://user-images.githubusercontent.com/38238032/200776135-b199c1ad-2fa1-44fd-915c-ce256f4fe7ac.png
  class SiteFeaturesDocsOverview
    include PageObject
    include SiteEditorsLinksCheckingHelper

    div(:youtube_video, xpath: '//div[contains(@class, "ct_new_video")]')
    link(:get_it_now_top, xpath: '//a[contains(@href, "download-docs.aspx") and contains(@class, "button")]')
    link(:see_it_in_action, xpath: '//a[contains(@href, "see-it-in-action.aspx") and contains(@class, "button")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(get_it_now_top_element) }
    end

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

    def click_download_pc
      xpath = '//*[@id="office_suite_download_desktop_download_now"]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteGetOnlyofficeDesktopApps.new(@instance)
    end

    def click_install_mobile
      xpath = '//*[@id="office_suite_download_desktop_mobile_install_now"]'
      @instance.webdriver.move_to_element_by_locator(xpath)
      @instance.webdriver.click_on_locator(xpath)
      SiteMobileApps.new(@instance)
    end
  end
end
