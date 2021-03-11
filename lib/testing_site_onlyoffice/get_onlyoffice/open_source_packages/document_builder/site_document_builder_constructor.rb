# Get download, install, release date, verson and what's new xpath for document builder block
#

module TestingSiteOnlyoffice
  class SiteDocumentBuilderConstructor
    attr_accessor :instance, :instruction_xpath, :download_xpath

    include PageObject

    def initialize(instance, installer)
      super(instance.webdriver.driver)
      @instance = instance
      @installer = installer
      @download_xpath = "//a[contains(@id,'onlyoffice_document_builder_for_#{installer}')]"
      @instruction_xpath = "#{@download_xpath}/../..//a[contains(@href,'gettingstarted')]"
      @whats_new_link = "#{@download_xpath}/../..//a[contains(@href,'CHANGELOG')]"
      @version_xpath = "#{@download_xpath}/../../div/p[1]"
      @release_date_xpath = "#{@download_xpath}/../../div/p[2]"
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.get_element(@download_xpath).present?
      end
    end

    def click_read_instruction
      @instance.webdriver.get_element(@instruction_xpath).click
    end

    def click_whats_new_link
      @instance.webdriver.get_element(@whats_new_link).click
    end

    def get_installer_version
      version_text = @instance.webdriver.get_text(@version_xpath)
      get_release_date_or_version(version_text)
    end

    def get_installer_release_date
      release_date_text = @instance.webdriver.get_text(@release_date_xpath)
      get_release_date_or_version(release_date_text)
    end

    def get_release_date_or_version(text)
      text.match(%r{\d+[./]\d+[./]\d+}).to_s
    end

    def get_extension
      { windows: :windows,
        debian: :deb,
        centos: :rpm }
    end
  end
end
