# frozen_string_literal: true

module TestingSiteOnlyoffice
  # General site sata
  class SiteData
    DEFAULT_ADMIN_NAME = 'admin-zero'
    DEFAULT_ADMIN_LASTNAME = 'admin-zero'
    DEFAULT_ADMIN_FULLNAME = 'admin-zero admin-zero'
    PORTAL_PASSWORD = '12345678'
    DOCSPACE_PASSWORD = '12345678a'

    CLIENT_EMAIL = 'client@qamail.teamlab.info'
    EMAIL_ADMIN = 'admin@qamail.teamlab.info'
    PARTNERS_EMAIL = 'partners@qamail.teamlab.info'
    EMAIL_FOR_BYPASSING_CAPTCHA = 'teamlab.ruby@gmail.com'

    NON_PROFIT_PORTAL_NAME = 'qateamlab-non-profit-portal'

    EMAIL_FOR_SITE = 'site@qamail.teamlab.info'

    FOLLOW_US_PENDING = ['Follow us on Instagram'].freeze

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
        integration_nextcloud: 'Integration (Nextcloud)',
        integration_wordpress: 'Integration (WordPress)',
        forms: 'Forms',
        documents: 'Documents',
        projects: 'Projects',
        crm: 'CRM',
        mail_calendar: 'Mail & Calendar',
        people_chat_community: 'People, Chat, Community'
      }
    end

    def self.courses_purposes
      {
        docs_educational_organizations: 'Using ONLYOFFICE Docs in educational organizations',
        administrating_docspace: 'Administrating ONLYOFFICE DocSpace',
        editing_documents_docspace: 'Editing documents in ONLYOFFICE DocSpace',
        custom_techfocused_training: 'Custom tech-focused training',
        working_with_docs_in_nextcloud: 'Working with docs in Nextcloud',
        working_with_docs_in_wordpress: 'Working with docs in WordPress',
        working_with_forms: 'Working with forms',
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
        docs_7_2_2_stress_test_report: 'stress_test_onlyoffice_7.2.2.pdf',
        docs_for_developers: 'onlyoffice_docs_for_developers.pdf',
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
        onlyoffice_secure_cloud_space: 'onlyoffice_secure_cloud_space.pdf',
        onlyoffice_document_processing_for_banking: 'onlyoffice_for_banking.pdf',
        onlyoffice_docs_for_nextcloud: 'onlyoffice_docs_for_nextcloud.pdf',
        onlyoffice_docs_for_owncloud: 'onlyoffice_docs_for_owncloud.pdf',
        document_collaboration_in_education: 'onlyoffice_docs_datasheet_education.pdf',
        onlyoffice_docs_cluster: 'onlyoffice_docs_in_your_cluster.pdf',
        onlyoffice_workspace_health: 'onlyoffice_workspace_for_health_institutions.pdf',
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
      %i[google twitter linkedin]
    end

    def self.blogs_download_app
      ['For Windows', 'For Linux', 'For Mac OS']
    end

    def self.left_menu_about_press_downloads
      ['Description', 'Logo', 'Screenshots', 'Video', 'Blog and Social Media Promotion Tiles']
    end

    def self.download_desktop_apps
      %i[windows linux macos]
    end

    def self.pricing_dev_option_keys
      %i[licence_development licence_production licence_non_production support_multi_tenancy support_recovery support_multi training_course access_to_api live_viewer mobile_apps desktop_apps]
    end

    # Method to generate all available options with default values set to true,
    # allowing for exceptions to be specified to toggle specific options to false.
    def self.pricing_dev_all_available_options_selected(exceptions = {})
      default_values = pricing_dev_option_keys.product([true]).to_h
      default_values.merge(exceptions)
    end
  end
end
