# frozen_string_literal: true

require_relative '../uninstall_feedback/site_install_canceled_page'
require_relative '../uninstall_feedback/site_account_canceled'
require_relative '../uninstall_feedback/site_desktop_uninstalled'
require_relative '../uninstall_feedback/site_registration_canceled'

module TestingSiteOnlyoffice
  # Helper methods for opening uninstall feedback pages
  # These methods use the URLs of the test site because emails are not tested on the production environment
  module SiteUninstallFeedbackOpeningPages
    def open_install_canceled
      url = config.server.end_with?('teamlab.info') ? "#{config.server}/install-canceled.aspx?Site_Testing=4testing" : "#{config.server}/install-canceled.aspx"
      @instance.webdriver.open(url)
      SiteInstallCanceledPage.new(@instance)
    end

    def open_account_canceled
      url = config.server.end_with?('teamlab.info') ? "#{config.server}/account-canceled.aspx?Site_Testing=4testing" : "#{config.server}/account-canceled.aspx"
      @instance.webdriver.open(url)
      SiteAccountCanceled.new(@instance)
    end

    def open_desktop_uninstalled
      url = config.server.end_with?('teamlab.info') ? "#{config.server}/desktop-uninstalled.aspx?Site_Testing=4testing" : "#{config.server}/desktop-uninstalled.aspx"
      @instance.webdriver.open(url)
      SiteDesktopUninstalled.new(@instance)
    end

    def open_registration_canceled
      url = config.server.end_with?('teamlab.info') ? "#{config.server}/registration-canceled.aspx?Site_Testing=4testing" : "#{config.server}/registration-canceled.aspx"
      @instance.webdriver.open(url)
      SiteRegistrationCanceled.new(@instance)
    end
  end
end
