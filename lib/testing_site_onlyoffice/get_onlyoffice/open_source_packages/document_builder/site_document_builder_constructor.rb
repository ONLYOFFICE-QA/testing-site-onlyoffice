# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Get download, install, release date, verson and what's new xpath for document builder block
  # https://user-images.githubusercontent.com/40513035/110755314-d9a37300-8259-11eb-8552-65c083de1b7a.png
  class SiteDocumentBuilderConstructor
    attr_accessor :instance, :instruction_xpath, :download_xpath, :whats_new_xpath, :version_xpath, :release_date_xpath

    include PageObject

    def initialize(instance, installer)
      super(instance.webdriver.driver)
      @instance = instance
      @installer = installer
      @download_xpath = "//a[contains(@id,'onlyoffice_document_builder_for_#{installer}')]"
      @instruction_xpath = "#{@download_xpath}/../..//a[contains(@href,'gettingstarted')]"
      @whats_new_xpath = "#{@download_xpath}/../..//a[contains(@href,'CHANGELOG')]"
      @version_xpath = "#{@download_xpath}/../../div/p[1]"
      @release_date_xpath = "#{@download_xpath}/../../div/p[2]"
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.get_element(@download_xpath).present?
      end
    end
  end
end
