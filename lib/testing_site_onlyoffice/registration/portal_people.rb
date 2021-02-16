module TestingSiteOnlyffice
  module PortalPeople
    def get_full_users_name_from_user_list(user_list)
      user_list_full_name = []
      user_list.each do |current_user|
        user_list_full_name << current_user.full_name
      end
      user_list_full_name
    end

    def current_portal_create_users(param)
      log_new_portal('Add users: Start')

      user_list = if SettingsData::EMAIL.include?('gmail')
                    get_user_list_by_param(param)
                  else
                    get_user_list_by_param_ired_mail(param)
                  end
      log_new_portal("Add users: Count: #{user_list.count}")
      if user_list.length > 1
        test = TestInstance.new(user_list.first)
        api = GeneralApiService.new(user_list.first.portal, user_list.first.email, user_list.first.password)
        user_link = api.portal.invite_user_url
        guest_link = api.portal.invite_visitor_url

        user_list.each do |current_user|
          next unless current_user.type != :admin

          begin
            log_new_portal("add #{current_user.full_name}: #{current_user.email}")
            link = current_user.type == :guest ? guest_link : user_link
            test.webdriver.open(link)
            add_user_page = SettingsGeneralAddNewUser.new(test)
            add_user_page.add_current_user_by_link(current_user)
          rescue StandardError
            log_new_portal("cant add user #{current_user.full_name}: #{current_user.email}")
          end
        end
        test.webdriver.quit
      end
      log_new_portal('Add users: Done')
      user_list
    end

    def get_user_list_by_param(param)
      portal_name = if param.custom_portal_flag
                      param.custom_portal
                    else
                      get_full_portal_name(param.portal_to_create)
                    end

      user_list = []
      if param.custom_user_list_flag
        custom_user_list = param.custom_user_list
        custom_user_list.each do |current_user|
          user_list << AuthData.new(portal_name, current_user.first_name, current_user.last_name, current_user.type,
                                    current_user.mail)
        end
      else
        mail_to_users = param.mail_to_users
        mail_to_users = MailAccount.new(SettingsData::LOGIN, SettingsData::PASSWORD) if param.mail_to_users.nil?

        count_users_to_add = param.count_users_to_add
        count_guest_to_add = param.count_guest_to_add

        user_list << AuthData.new(portal_name)
        added = 0

        count_users_to_add.times do |current_time|
          current_time += 1
          added = current_time
          mail = get_mail_to_user(Marshal.load(Marshal.dump(mail_to_users)), current_time,
                                  count_users_to_add <= mail_to_users.username.length)
          name = "user #{current_time.humanize}"
          user_data = AuthData.new(portal_name, name, name, :user, mail)
          user_list << user_data
        end

        count_guest_to_add.times do |current_time|
          current_time = current_time + added + 1
          mail = get_mail_to_user(Marshal.load(Marshal.dump(mail_to_users)), current_time,
                                  count_guest_to_add <= mail_to_users.username.length)
          name = "guest #{current_time.humanize}"
          user_data = AuthData.new(portal_name, name, name, :guest, mail)
          user_list << user_data
        end
      end
      user_list
    end

    def get_mail_to_user(clone, current_time, flag)
      if current_time != '1'
        if flag
          clone.username.insert(current_time.to_i, '.')
        else
          clone.username += current_time.to_s
        end
      end
      "#{clone.username} @gmail.com"
    end

    def get_user_list_by_param_ired_mail(param)
      portal_name = get_full_portal_name(param.portal_to_create)
      user_list = []
      if param.custom_user_list_flag
        custom_user_list = param.custom_user_list
        custom_user_list.each do |current_user|
          user_list << AuthData.new(portal_name, current_user.first_name, current_user.last_name, current_user.type,
                                    current_user.mail)
        end
      else
        mail_to_users = param.mail_to_users
        mail_to_guest = MailAccount.new(SettingsData::LOGIN_GUEST, SettingsData::PASSWORD)
        mail_to_users = MailAccount.new(SettingsData::LOGIN_USER, SettingsData::PASSWORD) if param.mail_to_users.nil?

        count_users_to_add = param.count_users_to_add
        count_guest_to_add = param.count_guest_to_add

        admin_data = AuthData.new(portal_name)
        admin_data.password = param.portal_pwd
        user_list << admin_data

        push_users_to_user_list(user_list, count_users_to_add, mail_to_users, :user)
        push_users_to_user_list(user_list, count_guest_to_add, mail_to_guest, :guest)
      end
      user_list
    end

    def push_users_to_user_list(user_list, count, mail, type)
      count.times do |current_time|
        current_time += 1
        email_address = get_mail_to_user_ired_mail(Marshal.load(Marshal.dump(mail)), current_time)
        name = "#{type}-#{current_time.humanize}"
        user_data = AuthData.new(user_list[0].portal, name, name, type, email_address)
        user_list << user_data
      end
    end

    def get_mail_to_user_ired_mail(clone, current_time)
      clone.username += current_time.to_s if current_time != 1
      "#{clone.username}@#{SettingsData::DOMAIN}"
    end

    def add_users_to_portal(portal_data, user_list)
      user_list.each do |current_user|
        next unless current_user.type != :admin

        p "current_user: #{current_user.first_name}"
        admin = AuthData.new(portal_data.portal_name, portal_data.portal_login, portal_data.portal_pwd)
        test = TestInstance.new(admin)
        begin
          login_page = LoginPage.new(test)
          main_page = login_page.login_with
          people_page = main_page.go_to_people
          invitation_link_form = people_page.open_invitation_link_form
          add_user_page = invitation_link_form.open_people_invitation_link_for(current_user.type)
          add_user_page.add_current_user_by_link_and_relogin(current_user)
        rescue StandardError
          p "cant add user: #{current_user.first_name}"
        end
        test.webdriver.quit
      end
    end
  end
end
