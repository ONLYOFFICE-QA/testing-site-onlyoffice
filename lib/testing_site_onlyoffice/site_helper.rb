# frozen_string_literal: true

require_relative 'portal_helper/portal_login_page'

module TestingSiteOnlyoffice
  # Helper methods for site initializing
  class SiteHelper
    attr_accessor :test, :user_list

    def log_new_portal(str)
      OnlyofficeLoggerHelper.log("Portal creation: #{str}")
    end

    def open_page_teamlab_office(config)
      log_new_portal('Init browser: Start')
      log_new_portal("Init browser: Open: #{config.server}")
      @test = SiteTestInstance.new(config)
      register_page = SiteHomePage.new(@test)
      log_new_portal('Init browser: Creating')
      [register_page, @test]
    end

    def create_portal_change_language_site(param, language = 'en-US')
      register_page, @test = SiteHelper.new.open_page_teamlab_office(config)
      register_page.change_language_and_create_portal(param, language)
      @test.webdriver.quit
    end

    def wrong_portal_name
      wrong_portal = SiteData.site_notification_page.dup.insert(10, Time.now.nsec.to_s)
      @test = SiteTestInstance.new(config)
      @test.webdriver.open('https://teamlab.info/?Site_Testing=4testing')
      @test.webdriver.open(wrong_portal)
      @test.webdriver.wait_until { @test.webdriver.driver.current_url.include? '/wrongportalname.aspx?url=' }
      SiteWrongPortal.new(@test)
    end

    def branch_name
      @test = SiteTestInstance.new(config)
      @test.webdriver.open('https://teamlab.info/revision')
      @test.webdriver.wait_until { @test.webdriver.driver.current_url.include? '/revision' }
      @test.webdriver.get_text('//body')
    end

    def registration_confirmation(confirmation_link, portal_data)
      @test = SiteTestInstance.new(config)
      @test.webdriver.open(confirmation_link)
      login_page = PortalLoginPage.new(@test)
      login_page.login_with(portal_data[:email], portal_data[:password])
      @test.webdriver.quit
    end
  end
end
