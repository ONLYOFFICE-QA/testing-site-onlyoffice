# frozen_string_literal: true

module TestingSiteOnlyoffice
  # /certificates.aspx
  # https://github.com/ONLYOFFICE-QA/testing-site-onlyoffice/assets/99170537/8c037879-973d-4dad-ab61-b53dcbb057ee
  class SiteAboutCertificates
    include PageObject
    include SiteDownloadHelper

    link(:start_in_the_cloud_button, xpath: '//a[@class="button red" and @href="/docspace-registration.aspx"]')

    # certificate with kylin OS
    link(:download_kylin_os_button, xpath: '//a[@id="linkid_2"]')
    link(:learn_details_kylin_os, xpath: '//a[contains(@href, "certified-by-kylin-os")]')
    link(:products_kylin_os, xpath: '//div[@class="cert_product_solution"]//a[contains(@href, "/docs-enterprise.aspx")]')

    # certificate with openKylin
    link(:download_openkylin_button, xpath: '//a[@id="linkid_4"]')
    link(:learn_details_openkylin, xpath: '//a[contains(@href, "certified-by-openkylin-os")]')
    link(:products_openkylin, xpath: '//div[@class="cert_product_solution"]//a[contains(@href, "/desktop.aspx")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(products_kylin_os_element)
      end
    end

    def click_learn_details_kylin_os
      learn_details_kylin_os_element.click
      @instance.webdriver.choose_tab(2)
      SiteAboutBlog.new(@instance)
    end

    def click_learn_details_openkylin
      learn_details_openkylin_element.click
      @instance.webdriver.choose_tab(2)
      SiteAboutBlog.new(@instance)
    end

    def click_product_kylin_os
      products_kylin_os_element.click
      SiteForBusinessDocsEnterpriseEdition.new(@instance)
    end

    def click_product_openkylin
      products_openkylin_element.click
      SiteFeaturesDesktop.new(@instance)
    end

    def click_start_in_the_cloud
      start_in_the_cloud_button_element.click
      SiteDocSpaceSignUp.new(@instance)
    end
  end
end
