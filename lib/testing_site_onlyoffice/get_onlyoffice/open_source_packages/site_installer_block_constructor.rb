# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Get download, install, github or what's new xpath of current block
  # https://user-images.githubusercontent.com/40513035/98486550-fd649700-222e-11eb-98f9-f46137322bf6.png
  class SiteBlockConstructor
    attr_accessor :instance, :instruction_xpath, :download_xpath

    include PageObject

    def initialize(instance, block, installer)
      super(instance.webdriver.driver)
      @instance = instance
      @instruction_xpath = "//div[contains(@class, '#{block}')]//p/a[contains(@href, '#{installer}') and contains(@href, 'helpcenter')]"
      @download_xpath = "#{@instruction_xpath}/../../../div/a"
      @github_link = "#{@instruction_xpath}/../../p/a[contains(@href, 'github')]"
      wait_to_load
    end

    def wait_to_load
      @instance.webdriver.wait_until do
        @instance.webdriver.get_element(@instruction_xpath).present?
      end
    end

    def click_read_instruction
      @instance.webdriver.get_element(@instruction_xpath).click
    end

    def click_install_button
      @instance.webdriver.get_element(@download_xpath).click
    end

    def click_github_link
      @instance.webdriver.get_element(@github_link).click
    end

    def github_link_visible?
      @instance.webdriver.get_element(@github_link).present?
    end
  end
end
