# Get install, instruction, buy or what's new xpath of current commercial packages installer block
# https://user-images.githubusercontent.com/40513035/98994364-bb926400-2540-11eb-8b40-f53e99ef2cbc.png
require_relative 'site_commercial_download_form'

module TestingSiteOnlyoffice
  class SiteCommercialBlockConstructor
    attr_accessor :instance, :instruction_xpath, :download_xpath, :version_xpath, :release_date_xpath

    include PageObject

    def initialize(instance, product, installer)
      super(instance.webdriver.driver)
      @instance = instance
      @product = product
      @installer = installer.to_sym
      if installer == 'ovhcloud'
        @download_xpath = "//a[contains(@href, '#{installer}')]"
      else
        @download_xpath = "//a[contains(@id, '#{product}_for_#{installer}') and not(contains(@id, 'buy'))]"
        @buy_xpath = "#{@download_xpath}/../a[contains(@id, 'buy')]"
        @instruction_xpath = "#{@download_xpath}/../../div/p/a[not(contains(@href, 'changelog'))]"
      end
      @version_xpath = "#{@download_xpath}/../../div/p[1]"
      @release_date_xpath = "#{@download_xpath}/../../div/p[2]"
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.get_element(@download_xpath).present?
      end
    end

    def click_install_button
      @instance.webdriver.get_element(@download_xpath).click
      return if SiteDownloadData.commercial_packages_without_download_form.include?(@installer)

      SiteCommercialDownloadForm.new(@instance)
    end

    def click_buy_button
      @instance.webdriver.get_element(@buy_xpath).click
      case @product
      when 'workspace_enterprise'
        SitePriceServerEnterprise.new(@instance)
      when 'docs_enterprise'
        SitePriceDocsEnterprise.new(@instance)
      when 'docs_developer'
        SitePriceDocsDeveloper.new(@instance)
      end
    end
  end
end
