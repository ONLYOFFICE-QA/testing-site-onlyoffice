module TestingSiteOnlyffice
  module TeamlabPortalRegWebHelper
    def create_portal_by_web(param, change_language_flag = StaticDataTeamLab.change_portal_language_flag, language = StaticDataTeamLab.current_language, site_language = 'en-US')
      log_new_portal('Start')
      create_current_portal_with_part(param, site_language)
      user_list = current_portal_create_users(param)
      mark_tips_disabled(user_list)
      current_portal_add_forum_wiki(param.add_forum_wiki)
      change_language_current_portal(change_language_flag, language)
      submit_all_users_by_mail(user_list, param)
      mark_bar_notification_as_read(param.remove_bar_notification)
      invoke_crm_entities_creation if param.create_crm_entities
      log_new_portal('Done')
      @test.webdriver.quit
      user_list
    end

    # snatch: first time CRM module page open invokes entities creation
    def invoke_crm_entities_creation
      OnlyofficeLoggerHelper.log('Going to invoke CRM entities creation')
      response = HTTParty.get "#{Teamlab.config.server}/products/crm", headers: { Authorization: Teamlab.config.token }
      OnlyofficeLoggerHelper.log("ok: #{response.successful?}")
      response
    end

    def create_current_portal_with_part(param, language = 'en-US')
      log_new_portal('Main Part: Start')
      register_page, @test = open_page_teamlab_office
      @main_page = register_page.create_portal_from_source(param,
                                                           language,
                                                           param.custom_user_list[0].first_name,
                                                           param.custom_user_list[0].mail)
      if StaticDataTeamLab.portal_version

        OnlyofficeLoggerHelper.log('Change portal version')
        GeneralApiService.new(PortalHelper.new.get_full_portal_name(param.portal_to_create),
                              param.custom_user_list[0].mail, param.custom_user_list[0].pwd)
                         .settings.change_version_by_name(StaticDataTeamLab.portal_version)
        sleep 10

      end
      if StaticDataTeamLab.new_docs_version
        PortalRequest.new(PortalHelper.new.get_full_portal_name(param.portal_to_create),
                          param.custom_user_list[0].mail, param.custom_user_list[0].pwd)
                     .change_version_editors
      end
      if StaticDataTeamLab.portal_timezone
        GeneralApiService.new(PortalHelper.new.get_full_portal_name(param.portal_to_create),
                              param.custom_user_list[0].mail, param.custom_user_list[0].pwd)
                         .settings.set_timezone(StaticDataTeamLab.portal_timezone)
      end
      @test.webdriver.execute_javascript('Teamlab.updateTipsSettings({ show: false });')
      sleep 1
      log_new_portal('Main Part: Done')
    end

    def change_language_current_portal(change_language_flag, language = StaticDataTeamLab.current_language)
      return unless change_language_flag

      log_new_portal('Change Language: Start')
      log_new_portal(language)
      settings = @main_page.go_to_settings
      settings.set_language(language)
      settings.apply_language_time_zone
      @main_page = settings.go_home
      log_new_portal('Change Language: Done')
    end

    def log_new_portal(str)
      OnlyofficeLoggerHelper.log("Portal creation: #{str}")
    end

    def current_portal_add_forum_wiki(add_forum_wiki)
      return unless add_forum_wiki

      log_new_portal('Add: Forum Wiki: Start')
      settings = @main_page.go_to_settings
      modules_page = settings.goto_modules
      modules_page.enable_module(:forums)
      modules_page.enable_module(:wiki)
      modules_page.submit_save_change_modules
      modules_page.go_home
      log_new_portal('Add: Forum Wiki: Done')
    end

    def mark_bar_notification_as_read(remove_bar_notification)
      return unless remove_bar_notification

      log_new_portal('Removing bar notification i.e. new release, adverts: start')
      documents = @main_page.go_to_documents
      kill_bar_notification
      documents.go_home
      log_new_portal('Removing bar notification i.e. new release, adverts: end')
    end

    def bar_visible?
      log_new_portal('checking bar notification presence')
      @test.webdriver.execute_javascript('return !!document.getElementById("ReleaseNewVersion")')
    end

    def kill_bar_notification
      return unless bar_visible?

      sleep 5
      @test.webdriver.driver.find_element(:xpath,
                                          '//*[@id="ReleaseNewVersion"]//*[contains(@class, "btn-close")]').click
    end

    def open_page_teamlab_office(portal = get_full_portal_name('www'))
      log_new_portal('Init browser: Start')
      admin = AuthData.new(portal)
      log_new_portal("Init browser: Open: #{portal}")
      @test = SiteTestInstance.new(admin)
      register_page = SiteHomePage.new(@test)
      log_new_portal('Init browser: Creating')
      [register_page, @test]
    end

    def get_language_list_from_new_portal(portal_creation_data)
      user_list = PortalHelper.new.init_portal(portal_creation_data)
      admin = user_list.find { |item| item.type == :admin }
      main_page, test = PortalHelper.new.init_instance(admin)
      settings = main_page.go_to_settings
      language_list = settings.get_language_list
      time_zone_list = settings.get_time_zone_list
      time_zone_full_list = settings.get_time_zone_full_list
      test.webdriver.quit
      [user_list, language_list, time_zone_list, time_zone_full_list]
    end

    def mark_tips_disabled(user_list)
      user_list.reverse_each do |user|
        GeneralApiService.new(user.portal, user.email).settings.change_tips_status(false)
      end
    end
  end
end
