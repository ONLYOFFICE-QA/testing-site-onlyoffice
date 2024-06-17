# frozen_string_literal: true

require_relative '../uninstall_feedback/site_install_canceled_page'
require_relative '../uninstall_feedback/site_account_canceled'
require_relative '../uninstall_feedback/site_desktop_uninstalled'
require_relative '../uninstall_feedback/site_registration_canceled'

module TestingSiteOnlyoffice
  # Helper methods for opening uninstall feedback pages
  module SiteUninstallFeedbackOpeningPages
    def open_install_canceled
      @instance.webdriver.open('https://teamlab.info/install-canceled.aspx?Site_Testing=4testing')
      SiteInstallCanceledPage.new(@instance)
    end

    def open_account_canceled
      @instance.webdriver.open('https://teamlab.info/account-canceled.aspx?Site_Testing=4testing')
      SiteAccountCanceled.new(@instance)
    end

    def open_desktop_uninstalled
      @instance.webdriver.open('https://teamlab.info/desktop-uninstalled.aspx?Site_Testing=4testing')
      SiteDesktopUninstalled.new(@instance)
    end

    def open_registration_canceled
      @instance.webdriver.open('https://teamlab.info/registration-canceled.aspx?Site_Testing=4testing')
      SiteRegistrationCanceled.new(@instance)
    end
  end
end
