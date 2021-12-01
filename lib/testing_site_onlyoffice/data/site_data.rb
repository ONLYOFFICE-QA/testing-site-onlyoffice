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

    def self.european_languages
      %w[en-GB fr-FR de-DE es-ES it-IT cs-CZ nl-NL]
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

    def self.white_papers
      {
        load_test_report: 'load_test_report.pdf',
        private_rooms_9_security_principles: 'private_rooms_9_security_principles.pdf',
        docs_integration_example: 'integration_example.pdf',
        for_government_offices: 'onlyoffice_for_government_offices.pdf',
        end_to_end_document_encryption: 'end-to-end_document_encryption.pdf',
        data_encryption_at_rest_1_0: 'data_encryption_at_rest_1.0.pdf'
      }
    end

    def self.datasheets
      {
        onlyoffice_docs_for_nextcloud: 'onlyoffice_docs_for_nextcloud.pdf',
        onlyoffice_docs_for_owncloud: 'onlyoffice_docs_for_owncloud.pdf',
        onlyoffice_docs: 'onlyoffice_docs.pdf',
        onlyoffice_workspace: 'onlyoffice_workspace.pdf',
        onlyoffice_private_room: 'onlyoffice_workspace_private_rooms.pdf',
        onlyoffice_for_law_firms: 'onlyoffice_datasheet_for_law_firms.pdf',
        onlyoffice_for_medical_industry: 'docs_datasheet_medical_3.pdf',
        onlyoffice_for_pharmaceutical_companies: 'onlyoffice_datasheet__for_pharmaceutical_industry.pdf',
        onlyoffice_for_non_profit_organizations: 'onlyoffice_datasheet_for_non-profits.pdf'
      }
    end

    def self.white_papers_and_datasheets
      white_papers.merge(datasheets)
    end

    def self.footer_links
      @footer_links ||= YAML.load_file("#{__dir__}/footer_links_info.yml")
    end

    def self.sign_in_with_network_list
      %i[google facebook twitter linkedin]
    end

    def self.blogs_download_app
      %w[winodws linux MacOs GooglePlay AppStore]
    end

    def self.download_desktop_apps
      %i[windows linux macos]
    end
  end
end
