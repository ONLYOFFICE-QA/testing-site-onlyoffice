# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Get download, install, release date, verson and what's new xpath for desktop
  # https://user-images.githubusercontent.com/40513035/112073762-f3826700-8b31-11eb-8362-d3314f511826.png
  class SiteDesktopConstructor
    attr_accessor :instance, :instruction_xpath, :download_xpath, :download_xpath_x86, :download_xpath_apple, :whats_new_link, :release_date_xpath, :version_xpath, :github_link

    include PageObject

    def initialize(instance, installer)
      super(instance.webdriver.driver)
      @instance = instance
      @installer = installer
      @download_xpath = fetch_download_xpath
      @download_xpath_x86 = "//a[contains(@id,'desktop_editors') and contains(@id,'#{@installer}') and contains(@id,'x86')]" if SiteDownloadData.desktop_download_list_type[:two_download_windows_files].include?(@installer.to_sym)
      @download_xpath_apple = "//a[contains(@id,'desktop_editors') and contains(@id,'#{@installer}') and contains(@id,'apple')]" if SiteDownloadData.desktop_download_list_type[:two_download_mac_files].include?(@installer.to_sym)
      @instruction_xpath = "(#{@download_xpath}/../..//a)[3]"
      @whats_new_link = "#{@download_xpath}/../..//a[contains(@href,'changelog')]"
      @version_xpath = "#{@download_xpath}/../../div/p[1]"
      @release_date_xpath = fetch_release_date
      @github_link = "(#{@download_xpath}/../..//a)[2]"
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.element_present?(@download_xpath)
      end
    end

    def fetch_download_xpath
      if SiteDownloadData.desktop_download_list_type[:two_download_windows_files].include?(@installer.to_sym)
        "//a[contains(@id,'desktop_editors') and contains(@id,'#{@installer}') and contains(@id,'x64')]"
      elsif SiteDownloadData.desktop_download_list_type[:two_download_mac_files].include?(@installer.to_sym)
        "//a[contains(@id,'desktop_editors') and contains(@id,'#{@installer}') and contains(@id,'intel')]"
      else
        "//a[contains(@id,'onlyoffice_desktop_editors') and contains(@id,'#{@installer}')]"
      end
    end

    def fetch_release_date
      if @installer.include?('mac') || @installer.include?('windows')
        "#{@download_xpath}/../../div/p[3]"
      else
        "#{@download_xpath}/../../div/p[2]"
      end
    end
  end
end
