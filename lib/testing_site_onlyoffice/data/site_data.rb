# frozen_string_literal: true

module TestingSiteOnlyoffice
  # General site sata
  class SiteData
    DEFAULT_ADMIN_NAME = 'admin-zero'
    DEFAULT_ADMIN_LASTNAME = 'admin-zero'
    DEFAULT_ADMIN_FULLNAME = 'admin-zero admin-zero'
    PORTAL_PASSWORD = '12345678'

    CLIENT_EMAIL = 'client@qamail.teamlab.info'
    EMAIL_ADMIN = 'admin@qamail.teamlab.info'
    PARTNERS_EMAIL = 'partners@qamail.teamlab.info'

    NON_PROFIT_PORTAL_NAME = 'qateamlab-non-profit-portal'

    EMAIL_FOR_SITE = 'site@qamail.teamlab.info'

    # @return [String] portal on which forgot password
    def self.site_notification_page
      if config.server.include?('.info')
        'https://nctautotest-site-notifications.teamlab.info'
      else
        case config.region
        when 'us'
          'https://nctautotest-notifications-site-com.onlyoffice.com'
        when 'eu'
          'https://nctautotest-notifications-site-eu.onlyoffice.eu'
        when 'sg'
          'https://nctautotest-notifications-site-sg.onlyoffice.sg'
        else
          raise "Doesn't exist region=#{config.region}"
        end
      end
    end

    def self.site_languages
      %w[en-US en-GB ru-RU fr-FR de-DE es-ES pt-BR it-IT cs-CZ nl-NL ja-JP zh-CN]
    end

    def self.courses_modules
      {
        documents: 'Documents',
        projects: 'Projects',
        crm: 'CRM',
        mail_calendar: 'Mail & Calendar',
        people_chat_community: 'People, Chat, Community'
      }
    end

    def self.courses_purposes
      {
        office_suite: 'Office suite',
        working_with_customers: 'Working with customers',
        working_in_a_team: 'Working in a team',
        administrating_the_portal: 'Administrating the portal',
        vip_package: 'VIP package',
        custom_package: 'Custom package'
      }
    end

    def self.all_training_courses
      courses_modules.merge(courses_purposes)
    end
  end
end
