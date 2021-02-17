module TestingSiteOnlyoffice
  module PortalMail
    def submit_all_users_by_mail(users, params)
      return unless params.submit_users_by_mail

      log_new_portal('Submit All Users: Start')
      users = Array(users)
      api_people = GeneralApiService.new(Teamlab.config.server, Teamlab.config.username).people
      users.map { |user| user unless api_people.is_user_activated? user.mail }.compact
      users.each { |user| api_people.activate_user_by_email(user.mail) }
      log_new_portal('Submit All Users: Done')
    end

    # user = AuthData.new(any params) or hash(see in "submit_invited_user" method), link = https://portal-name.onlyoffice.com/info?any keys
    # method will open browser, add passwords on invite page, click confirm and close browser
    def submit_user_by_link_web(user, link)
      test_session = SiteTestInstance.new(AuthData.new(link))
      general_invite_page = SettingsGeneralAddNewUser.new(test_session)
      general_invite_page.submit_invited_user(user)
      test_session.webdriver.quit
    end

    def get_user_invite_link_from_body(expected_string, portal, mail_helper = Gmail_helper.new)
      body = if mail_helper.class.to_s == 'Gmail_helper'
               mail_helper.get_body_message_by_title(portal, expected_string)
             else
               mail_helper.get_html_body_email_by_subject(subject: expected_string, search: portal)
             end
      raise "Does not exists mail with subject: #{expected_string}" unless body

      parse_subject(portal, body)
    end

    # Attantion!!Parameter user must have value portal is correct
    def submit_user(expected_string, user_data, gmail_helper = Gmail_helper.new)
      link = get_user_invite_link_from_body(expected_string, user_data.portal, gmail_helper)
      submit_user_by_link_web(user_data, link)
    end

    def parse_subject(current_portal_full, current_subject)
      link = current_subject[current_subject.index("#{current_portal_full} /confirm")..current_subject.length]
      link.split('">')[0]
    end
  end
end
