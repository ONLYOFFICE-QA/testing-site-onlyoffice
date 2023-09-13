# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Helper methods for constructor block installers
  module SiteBlockConstructorHelper
    # Method that clicks the link on the block.
    # The page /download-desktop.aspx#desktop will automatically scroll to the section with
    # downloads provided for your device's OS, in our case to the Linux section.
    # In order to avoid "click intercepted" error, JS methods here will scroll to the needed sections
    # depending on the installer being tested.
    # Sleep is added to wait until scroll is finished
    # @param [String] xpath - xpath of the link
    # @param [String] os - installer being tested(e.g. 'macos_10')
    def click_constructor_link(xpath, os)
      if os.include?('windows')
        @instance.webdriver.execute_javascript("$('html, body').animate({ 'scrollTop': $('.windows-new-icon').offset().top - topOffset }, 400)")
      elsif os.include?('macos')
        @instance.webdriver.execute_javascript("$('html, body').animate({ 'scrollTop': $('.dwn-mp-desktop .macos-icon').offset().top - topOffset }, 400)")
      end
      sleep 2
      @instance.webdriver.get_element(xpath).click
      wait_for_long_loading_page(xpath)
    end

    def get_installer_release_date_or_version(date_xpath)
      date_text = @instance.webdriver.get_text(date_xpath)
      fetch_release_date_or_version(date_text)
    end

    def fetch_release_date_or_version(text)
      date_version = text.match(%r{\d+[./]\d+[./]\d+}).to_s
      return date_version unless date_version.empty?

      text.match(%r{\d+[./]\d+}).to_s
    end

    private

    # Additional wait if loading page usually very long
    # This is very actual for appimage hub page
    # And sometimes for helpcenter page
    def wait_for_long_loading_page(xpath)
      OnlyofficeLoggerHelper.sleep_and_log('Waiting for long loading page', 60 * 3) if xpath.include?('appimage')
      return unless xpath.include?('workspace_enterprise_for_centos') || xpath.include?('workspace_enterprise_for_windows') || xpath.include?('workspace_enterprise_for_debian')

      OnlyofficeLoggerHelper.sleep_and_log('Waiting for long loading page', 60)
    end
  end
end
