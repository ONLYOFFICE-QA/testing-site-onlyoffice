# frozen_string_literal: true

require_relative 'about/site_about'
require_relative 'about/training_courses/site_about_training_courses'
require_relative 'about/site_blog'

require_relative 'additional_products/site_help_center'

require_relative 'data/site_data'
require_relative 'data/site_download_data'
require_relative 'data/site_notification_data'
require_relative 'data/site_prices_data'
require_relative 'data/site_private_data'

require_relative 'footer/site_document_builder/site_document_builder'
require_relative 'footer/contact_us/site_callback'
require_relative 'footer/support/site_order_demo'
require_relative 'footer/support/site_support_contact_form'
require_relative 'footer/follow_us_on/site_subscribe'
require_relative 'footer/follow_us_on/site_subscribe_confirmation'

require_relative 'get_onlyoffice/open_source_packages/site_open_source_docs'
require_relative 'get_onlyoffice/open_source_packages/connectors/site_open_source_connectors'
require_relative 'get_onlyoffice/open_source_packages/document_builder/site_open_source_document_builder'
require_relative 'get_onlyoffice/desktop_and_mobile/desktop/site_desktop_apps'
require_relative 'get_onlyoffice/desktop_and_mobile/site_mobile_apps'
require_relative 'get_onlyoffice/open_source_packages/site_open_source_bundles'
require_relative 'get_onlyoffice/open_source_packages/site_open_source_groups'
require_relative 'get_onlyoffice/commercial_packages/site_commercial_docs'
require_relative 'get_onlyoffice/commercial_packages/site_commercial_workspace'
require_relative 'get_onlyoffice/site_sign_up'
require_relative 'get_onlyoffice/site_sign_in'

require_relative 'modules/site_toolbar'
require_relative 'modules/cookie_window'
require_relative 'modules/site_footer'
require_relative 'modules/site_languages'
require_relative 'modules/additional_methods/hourly_forgot_password_helper'

require_relative 'partners/site_partners_request'

require_relative 'pricing/site_pricing_server_enterprise'
require_relative 'pricing/price_cloud/site_pricing_cloud'
require_relative 'pricing/site_pricing_docs_enterprise'
require_relative 'pricing/site_pricing_docs_developer'

require_relative 'products/connectors/site_products_connectors_onlyoffice'
require_relative 'products/site_products_android'
require_relative 'products/site_products_desktop'
require_relative 'products/site_products_docs'
require_relative 'products/docs/site_products_document_editor'
require_relative 'products/docs/site_products_spreadsheet_editor'
require_relative 'products/docs/site_products_presentation_editor'
require_relative 'products/site_products_groups'
require_relative 'products/groups/site_products_calendar'
require_relative 'products/groups/site_products_crm'
require_relative 'products/groups/site_products_document_manager'
require_relative 'products/groups/site_products_mail'
require_relative 'products/groups/site_products_projects'
require_relative 'products/groups/site_products_community'
require_relative 'products/site_products_ios'
require_relative 'products/site_products_workspace'
require_relative 'products/site_connectors'
require_relative 'products/site_products_security'

require_relative 'search/site_search'

require_relative 'solutions/nonprofit/site_nonprofits'
require_relative 'solutions/site_home_use'

require_relative 'support_chat/site_support_chat'

require_relative 'portal_helper/portal_helper'
require_relative 'portal_helper/portal_version'

require_relative 'site_helper'
require_relative 'site_version_helper'
require_relative 'site_wrong_portal'
require_relative 'site_notification_helper'

module TestingSiteOnlyoffice
  # Site home page
  # https://user-images.githubusercontent.com/40513035/120973030-42986b00-c723-11eb-81f4-94982ce056cd.png
  class SiteHomePage
    attr_accessor :instance

    include CookieWindow
    include HourlyForgotPasswordHelper
    include PageObject
    include PortalVersion
    include SiteFooter
    include SiteSearch
    include SiteSupportChatPopup
    include SiteToolbar

    link(:try_in_the_cloud, xpath: '//article//a[contains(@href,"registration")]')

    link(:download_desktop_windows, xpath: '//a[contains(@class,"mpd_for_windows")]')
    link(:download_desktop_linux, xpath: '//a[contains(@class,"mpd_for_linux")]')
    link(:download_desktop_macos, xpath: '//a[contains(@class,"mpd_for_macos")]')
    link(:download_app_store, xpath: '//a[contains(@class,"mpd_appstore")]')
    link(:download_google_play, xpath: '//a[contains(@class,"mpd_googleplay")]')

    def initialize(instance)
      super(instance.webdriver.driver)
      @instance = instance
      wait_to_load
      agree_with_cookie_if_shown
      hide_support_chat_if_shown
    end

    def wait_to_load
      @instance.webdriver.wait_until { try_in_the_cloud_element.present? }
    end

    def create_portal(params = {})
      set_page_language(params.fetch(:language, 'en-US'))
      complete_registration_wizard(params)
    end

    def change_language_and_create_portal(param, language = 'en-US')
      set_page_language(language)
      complete_registration_wizard(param)
    end

    def complete_registration_wizard(params = {})
      single_step_registration = start_registration
      single_step_registration.fill_data(params)
    end

    def start_registration
      OnlyofficeLoggerHelper.log('Starting registration')
      try_in_the_cloud_element.click
      SiteSignUp.new(@instance)
    end

    def send_forgot_password_from_sign_in(email = mail_for_forgotten_password.username)
      sign_in = click_link_on_toolbar(:sign_in)
      sign_in.send_forgot_password(email)
    end
  end
end
