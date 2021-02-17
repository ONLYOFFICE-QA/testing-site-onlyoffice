module TestingSiteOnlyoffice
  class SiteHelper
    attr_accessor :test, :user_list

    def create_portal_change_language_wizard(param, language = 'en-US', user_name = AuthData::DEFAULT_ADMIN_NAME)
      wizard_first = initialize_portal(param, 'en-US', user_name)
      wizard_first.set_language(language)
      completion_registration(wizard_first, param.portal_pwd)
    end

    def create_portal_change_language_site(param, language = 'en-US', user_name = AuthData::DEFAULT_ADMIN_NAME, email = SettingsData::EMAIL)
      initialize_portal(param, language, user_name, email)
      @test.webdriver.quit
      @user_list[0]
    end

    def create_portal_change_email_site(param, email, language = 'en-US', user_name = AuthData::DEFAULT_ADMIN_NAME)
      initialize_portal(param, language, user_name, email)
      @test.webdriver.quit
      @user_list[0]
    end

    def completion_registration(wizard_first, portal_pwd = nil)
      if portal_pwd.nil?
        wizard_first.input_password
      else
        wizard_first.input_password(portal_pwd)
      end
      wizard_first.next_page
      @test.webdriver.quit
      @user_list[0]
    end

    def initialize_portal(param, language = 'en-US', user_name = AuthData::DEFAULT_ADMIN_NAME, email = SettingsData::EMAIL)
      portal_helper = PortalHelper.new
      @portal_name = portal_helper.get_full_portal_name(param.portal_to_create)
      @user_list = portal_helper.current_portal_create_users(param)
      register_page, @test = portal_helper.open_page_teamlab_office
      register_page.create_portal_from_source(param, language, user_name, email)
    end

    def get_list_languages_from_wizard(param)
      wizard_first = initialize_portal(param)
      languages_list = wizard_first.get_languages_list
      @test.webdriver.quit
      languages_list
    end

    def wrong_portal_name
      wrong_portal = SiteData::PORTAL_ADDRESS.dup.insert(10, Time.now.nsec.to_s)
      @test = SiteTestInstance.new
      @test.webdriver.open('https://teamlab.info/?Site_Testing=4testing')
      @test.webdriver.open(wrong_portal)
      @test.webdriver.wait_until { @test.webdriver.driver.current_url.include? '/wrongportalname.aspx?url=' }
      SiteWrongPortal.new(@test)
    end

    # @return [String] url of site
    def self.site_url
      return 'https://teamlab.info' if StaticDataTeamLab.portal_type == '.info'
      return 'https://www.onlyoffice.com' if StaticDataTeamLab.portal_type == '.com'
    end

    # @return [String] version of site by url `site/revision`
    def self.fetch_site_version
      uri = URI("#{site_url}/revision?Site_Testing=4testing")
      Net::HTTP.get(uri).strip
    rescue StandardError => e
      OnlyofficeLoggerHelper.log("Cannot get site version because of #{e}")
      Time.now.strftime('%Y-%m-%d')
    end
  end
end
