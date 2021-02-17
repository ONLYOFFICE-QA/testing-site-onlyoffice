# Get install, instruction, version or release date xpaths of current Document Builder installer block
# https://user-images.githubusercontent.com/40513035/100555121-7b561400-32aa-11eb-9763-c0625f914b16.png
module TestingSiteOnlyoffice
  class SiteDocumentBuilderBlockConstructor
    attr_accessor :instance, :instruction_xpath, :download_xpath

    include PageObject

    def initialize(instance, installer)
      super(instance.webdriver.driver)
      @instance = instance
      @download_xpath = "//a[contains(@href, '#{installer}')]"
      @installer_info_xpath = "//p[contains(@class, '#{installer}')]"
      case installer
      when 'deb'
        @instruction_xpath = "#{@installer_info_xpath}/../a[contains(@href, 'gettingstarted')][1]"
      when 'rpm'
        @instruction_xpath = "#{@installer_info_xpath}/../a[contains(@href, 'gettingstarted')][2]"
      when 'windows'
        @instruction_xpath = "#{@installer_info_xpath}/../a[contains(@href, 'gettingstarted')]"
      end
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

    def click_install_button
      @instance.webdriver.click_on_locator(@download_xpath)
    end

    def get_version_and_release_date
      installer_info_text = @instance.webdriver.get_text(@installer_info_xpath)
      installer_info_text.scan(%r{\d+[./]\d+[./]\d+})
    end

    def download_button_visible?
      @instance.webdriver.element_visible?(@download_xpath)
    end
  end
end
