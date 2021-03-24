# Get download, install, release date, verson and what's new xpath for desktop
# https://user-images.githubusercontent.com/40513035/112073762-f3826700-8b31-11eb-8362-d3314f511826.png

module TestingSiteOnlyoffice
  class SiteDesktopConstructor
    attr_accessor :instance, :instruction_xpath, :download_xpath, :download_xpath_x86, :whats_new_link, :release_date_xpath, :version_xpath, :github_link

    include PageObject

    def initialize(instance, installer)
      super(instance.webdriver.driver)
      @instance = instance
      if SiteDownloadData.desktop_download_list[:two_download_files].include?(installer.to_sym)
        @download_xpath = "//a[contains(@id,'desktop_editors') and contains(@id,'#{installer}') and contains(@id,'x64')]"
        @download_xpath_x86 = "//a[contains(@id,'desktop_editors') and contains(@id,'#{installer}') and contains(@id,'x86')]"
      else
        @download_xpath = "//a[contains(@id,'onlyoffice_desktop_editors') and contains(@id,'#{installer}')]"
      end
      @instruction_xpath = "(#{@download_xpath}/../..//a)[3]"
      @whats_new_link = "#{@download_xpath}/../..//a[contains(@href,'changelog')]"
      @version_xpath = "#{@download_xpath}/../../div/p[1]"
      @release_date_xpath = if installer.include?('mac') || installer.include?('windows')
                              "#{@download_xpath}/../../div/p[3]"
                            else
                              "#{@download_xpath}/../../div/p[2]"
                            end
      @github_link = "(#{@download_xpath}/../..//a)[2]"
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.get_element(@download_xpath).present?
      end
    end
  end
end
