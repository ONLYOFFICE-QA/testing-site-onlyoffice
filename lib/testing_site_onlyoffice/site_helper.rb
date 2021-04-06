module TestingSiteOnlyoffice
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

    def create_portal_change_language_site(param, language = 'en-US', user_name = AuthData::DEFAULT_ADMIN_NAME, email = SettingsData::EMAIL)
      portal_helper = PortalHelper.new
      @portal_name = portal_helper.get_full_portal_name(param.portal_to_create)
      @user_list = portal_helper.current_portal_create_users(param)
      register_page, @test = SiteHelper.new.open_page_teamlab_office(config)
      register_page.change_language_and_create_portal(param, language, user_name, email)
      @test.webdriver.quit
      @user_list[0]
    end

    def wrong_portal_name
      wrong_portal = SiteData.site_notification_page.dup.insert(10, Time.now.nsec.to_s)
      @test = SiteTestInstance.new(config)
      @test.webdriver.open('https://teamlab.info/?Site_Testing=4testing')
      @test.webdriver.open(wrong_portal)
      @test.webdriver.wait_until { @test.webdriver.driver.current_url.include? '/wrongportalname.aspx?url=' }
      SiteWrongPortal.new(@test)
    end

    def registration_confirmation(confirmation_link, mail = SettingsData::EMAIL_ADMIN, pwd = SettingsData::PORTAL_PASSWORD)
      @test = SiteTestInstance.new(config)
      @test.webdriver.open(confirmation_link)
      login_page = LoginPage.new(@test)
      login_page.login_with(mail, pwd)
      @test.webdriver.quit
    end
  end
end
