# frozen_string_literal: true

require_relative 'about/site_about'
require_relative 'about/site_about_customer_stories'
require_relative 'about/training_courses/site_about_training_courses'
require_relative 'about/white_paper_and_datasheets/site_about_white_papers'
require_relative 'about/site_about_blog'
require_relative 'about/site_about_contribute'
require_relative 'about/site_about_awards'
require_relative 'about/site_about_events'
require_relative 'about/site_about_contacts'
require_relative 'about/site_about_gift_shop'
require_relative 'about/site_about_press_downloads'
require_relative 'about/site_about_webinars'
require_relative 'about/site_about_jobs'
require_relative 'about/site_about_forum'

require_relative 'additional_products/site_about_help_center'

require_relative 'data/site_data'
require_relative 'data/main_page_links_data'
require_relative 'data/site_download_data'
require_relative 'data/site_notification_data'
require_relative 'data/site_prices_data'
require_relative 'data/site_private_data'

require_relative 'footer/developer/site_document_builder/site_document_builder'
require_relative 'footer/solutions/site_for_developers'
require_relative 'footer/contact_us/site_callback'
require_relative 'footer/support/site_order_demo'
require_relative 'footer/support/site_support_contact_form'
require_relative 'footer/follow_us_on/site_subscribe'
require_relative 'footer/follow_us_on/site_subscribe_confirmation'
require_relative 'footer/solutions/nonprofit/site_nonprofits'
require_relative 'footer/solutions/site_home_use'
require_relative 'footer/resources/site_compare_other_suites'
require_relative 'footer/support/site_wopi_support'

require_relative 'get_onlyoffice/other_products/connectors/site_get_onlyoffice_connectors'
require_relative 'get_onlyoffice/document_builder/site_get_onlyoffice_download_doc_builder'
require_relative 'get_onlyoffice/desktop_and_mobile/desktop/site_get_onlyoffice_desktop_apps'
require_relative 'get_onlyoffice/desktop_and_mobile/site_mobile_apps'
require_relative 'get_onlyoffice/other_products/site_open_source_bundles'
require_relative 'get_onlyoffice/other_products/site_other_products_groups'
require_relative 'get_onlyoffice/onlyoffice_docs/site_get_onlyffice_docs_community'
require_relative 'get_onlyoffice/onlyoffice_docs/site_get_onlyoffice_docs_enterprise'
require_relative 'get_onlyoffice/onlyoffice_docs/site_get_onlyoffice_docs_developer'
require_relative 'get_onlyoffice/onlyoffice_docs/site_doсs_registration_page'
require_relative 'get_onlyoffice/onlyoffice_docs/site_doсs_registration_page/site_docs_registration_data'
require_relative 'get_onlyoffice/onlyoffice_workspace/site_get_onlyoffice_workspace_enterprise'
require_relative 'get_onlyoffice/onlyoffice_workspace/site_workspace_community'
require_relative 'get_onlyoffice/site_get_onlyoffice_sign_up'
require_relative 'get_onlyoffice/site_get_onlyoffice_sign_in'
require_relative 'get_onlyoffice/modules/site_download_helper'
require_relative 'get_onlyoffice/site_get_onlyoffice_web_hosting'
require_relative 'get_onlyoffice/site_get_onlyoffice_docs_registration'

require_relative 'for_business/site_enterprise'
require_relative 'for_business/site_for_business'
require_relative 'for_business/site_for_business_docs_enterprise_edition'
require_relative 'for_business/site_for_business_workspace'
require_relative 'for_business/workspace/site_for_business_calendar'
require_relative 'for_business/workspace/site_for_business_crm'
require_relative 'for_business/workspace/site_for_business_document_manager'
require_relative 'for_business/workspace/site_for_business_mail'
require_relative 'for_business/workspace/site_for_business_projects'
require_relative 'for_business/for_business_education'
require_relative 'for_business/nextcloud/site_nextcloud'
require_relative 'for_business/alfresco/site_alfresco'
require_relative 'for_business/confluence/site_confluence'
require_relative 'for_business/owncloud/site_owncloud'
require_relative 'for_business/moodle/site_moodle'

require_relative 'for_developers/site_for_developers_doc_dev_edition'
require_relative 'for_developers/site_for_developers_doc_builder'
require_relative 'for_developers/site_for_developers_api_doc'

require_relative 'modules/site_toolbar'
require_relative 'modules/site_home_page_helper'
require_relative 'modules/cookie_window'
require_relative 'modules/site_footer'
require_relative 'modules/site_languages'
require_relative 'modules/additional_methods/hourly_forgot_password_helper'

require_relative 'partners/site_partners_request'
require_relative 'partners/site_partners_affiliates'
require_relative 'partners/site_partners_resellers'
require_relative 'partners/site_partners_find'

require_relative 'pricing/site_pricing_server_enterprise'
require_relative 'pricing/price_cloud/site_pricing_cloud'
require_relative 'pricing/site_pricing_docs_enterprise'
require_relative 'pricing/site_pricing_docs_developer'

require_relative 'features/connectors/site_features_connectors_onlyoffice'
require_relative 'features/docs/site_features_docs_overview'
require_relative 'features/site_features_android'
require_relative 'features/site_features_desktop'
require_relative 'features/site_features_docs'
require_relative 'features/docs/site_features_document_editor'
require_relative 'features/docs/site_features_spreadsheet_editor'
require_relative 'features/docs/site_features_presentation_editor'
require_relative 'features/docs/site_features_form_creator'
require_relative 'features/site_pdf_reader_converter'
require_relative 'features/site_features_see_it_in_action'
require_relative 'features/site_features_oforms'
require_relative 'features/site_features_ios'
require_relative 'features/site_features_security'
require_relative 'features/doc_edition/site_features_cloud_edition'
require_relative 'features/workspace_edition/cloud_edition'
require_relative 'features/workspace_edition/enterprise_edition'

require_relative 'search/site_search'

require_relative 'support_chat/site_support_chat'

require_relative 'portal_helper/portal_helper'
require_relative 'portal_helper/portal_version'

require_relative 'site_helper'
require_relative 'site_version_helper'
require_relative 'site_wrong_portal'
require_relative 'site_notification_helper'
require_relative 'convert_page'

module TestingSiteOnlyoffice
  # Site home page
  # https://user-images.githubusercontent.com/38238032/196676551-39d307b2-d866-4867-820c-6045a7eddb04.png
  class SiteHomePage
    attr_accessor :instance

    include CookieWindow
    include HourlyForgotPasswordHelper
    include PageObject
    include PortalVersion
    include SiteDownloadHelper
    include SiteFooter
    include SiteHomePageHelper
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
      set_page_language(@instance.config.language)
      wait_to_load
      agree_with_cookie_if_shown
      hide_support_chat_if_shown
    end

    def wait_to_load
      @instance.webdriver.wait_until { @instance.webdriver.element_present?(try_in_the_cloud_element) }
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
      SiteGetOnlyofficeSignUp.new(@instance)
    end

    def send_forgot_password_from_sign_in(email = mail_for_forgotten_password.username)
      sign_in = click_link_on_toolbar(:get_onlyoffice_sign_in)
      sign_in.send_forgot_password(email)
    end

    def open_sublink(link)
      @instance.webdriver.open("#{config.server}/#{link}")
      @instance.webdriver.wait_until { @instance.webdriver.driver.current_url.include? "/#{link}" }
    end

    def page_body
      @instance.webdriver.get_text('//body')
    end
  end
end
