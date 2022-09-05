# frozen_string_literal: true

require_relative 'about/site_about'
require_relative 'about/site_customer_stories'
require_relative 'about/training_courses/site_about_training_courses'
require_relative 'about/white_paper_and_datasheets/site_white_papers'
require_relative 'about/site_blog'
require_relative 'about/site_contribute'
require_relative 'about/site_awards'
require_relative 'about/site_about_events'
require_relative 'about/site_contacts'
require_relative 'about/site_about_gift_shop'
require_relative 'about/site_about_press_downloads'
require_relative 'about/site_webinars'
require_relative 'about/site_jobs'

require_relative 'additional_products/site_help_center'

require_relative 'data/site_data'
require_relative 'data/main_page_links_data'
require_relative 'data/site_download_data'
require_relative 'data/site_notification_data'
require_relative 'data/site_prices_data'
require_relative 'data/site_private_data'

require_relative 'footer/developer/site_document_builder/site_document_builder'
require_relative 'footer/contact_us/site_callback'
require_relative 'footer/support/site_order_demo'
require_relative 'footer/support/site_support_contact_form'
require_relative 'footer/follow_us_on/site_subscribe'
require_relative 'footer/follow_us_on/site_subscribe_confirmation'
require_relative 'footer/solutions/nonprofit/site_nonprofits'
require_relative 'footer/solutions/site_home_use'
require_relative 'footer/resources/site_compare_other_suites'
require_relative 'footer/support/site_wopi_support'

require_relative 'get_onlyoffice/other_products/connectors/site_other_products_connectors'
require_relative 'get_onlyoffice/other_products/document_builder/site_other_products_document_builder'
require_relative 'get_onlyoffice/desktop_and_mobile/desktop/site_desktop_apps'
require_relative 'get_onlyoffice/desktop_and_mobile/site_mobile_apps'
require_relative 'get_onlyoffice/other_products/site_open_source_bundles'
require_relative 'get_onlyoffice/other_products/site_other_products_groups'
require_relative 'get_onlyoffice/onlyoffice_docs/site_docs_community'
require_relative 'get_onlyoffice/onlyoffice_docs/site_docs_enterprise'
require_relative 'get_onlyoffice/onlyoffice_docs/site_docs_developer'
require_relative 'get_onlyoffice/onlyoffice_docs/site_doсs_registration_page'
require_relative 'get_onlyoffice/onlyoffice_docs/site_doсs_registration_page/site_docs_registration_data'
require_relative 'get_onlyoffice/onlyoffice_workspace/site_workspace_enterprise'
require_relative 'get_onlyoffice/onlyoffice_workspace/site_workspace_community'
require_relative 'get_onlyoffice/site_sign_up'
require_relative 'get_onlyoffice/site_sign_in'
require_relative 'get_onlyoffice/modules/site_download_helper'
require_relative 'get_onlyoffice/compare_edition/site_compare_edition'

require_relative 'integration/site_integration'
require_relative 'integration/nextcloud/site_nextcloud'
require_relative 'integration/alfresco/site_alfresco'
require_relative 'integration/confluence/site_confluence'
require_relative 'integration/hum_hub/site_hum_hub'
require_relative 'integration/liferay/site_liferay'
require_relative 'integration/owncloud/site_owncloud'
require_relative 'integration/share_point/site_share_point'
require_relative 'integration/redmine/site_redmine'
require_relative 'integration/jira/site_jira'
require_relative 'integration/plone/site_plone'
require_relative 'integration/nuxeo/site_nuxeo'
require_relative 'integration/moodle/site_moodle'
require_relative 'integration/chamilo/site_chamilo'

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

require_relative 'products/connectors/site_products_connectors_onlyoffice'
require_relative 'products/site_products_android'
require_relative 'products/site_products_desktop'
require_relative 'products/site_products_docs'
require_relative 'products/docs/site_products_document_editor'
require_relative 'products/docs/site_products_spreadsheet_editor'
require_relative 'products/docs/site_products_presentation_editor'
require_relative 'products/docs/site_products_form_creator'
require_relative 'products/groups/site_products_calendar'
require_relative 'products/groups/site_products_crm'
require_relative 'products/groups/site_products_document_manager'
require_relative 'products/groups/site_products_mail'
require_relative 'products/groups/site_products_projects'
require_relative 'products/site_products_ios'
require_relative 'products/site_products_workspace'
require_relative 'products/site_products_security'
require_relative 'products/doc_edition/site_products_enterprise_edition'
require_relative 'products/doc_edition/site_products_developer_edition'
require_relative 'products/doc_edition/site_products_cloud_edition'
require_relative 'products/workspace_edition/cloud_edition'
require_relative 'products/workspace_edition/enterprise_edition'

require_relative 'search/site_search'

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
      SiteSignUp.new(@instance)
    end

    def send_forgot_password_from_sign_in(email = mail_for_forgotten_password.username)
      sign_in = click_link_on_toolbar(:sign_in)
      sign_in.send_forgot_password(email)
    end

    def open_sublink(link)
      @instance.webdriver.open("#{config.server}/#{link}")
      @instance.webdriver.wait_until { @instance.webdriver.driver.current_url.include? "/#{link}" }
    end

    def page_body
      @test.webdriver.get_text('//body')
    end

    def open_convert_page
      open_sublink('convert.aspx')
      ConvertSite.new(@instance)
    end
  end
end
