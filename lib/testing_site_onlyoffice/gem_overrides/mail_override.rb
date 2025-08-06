# frozen_string_literal: true

require_relative 'mail_parse_body'

module OnlyofficeIredmailHelper
  # Additional method to work with IredMailHelper class
  class IredMailHelper
    def check_pricing_docspace_mail_body(params = {})
      body = MailParseBody.new(params)
      body.basic_email_content_check &&
        body.multi_server_deployment? &&
        body.training_courses?
    end

    def check_pricing_enterprise_mail_body(params = {})
      body = MailParseBody.new(params)
      body.basic_email_content_check &&
        body.recovery_support? &&
        body.multi_server_deployment? &&
        body.training_courses? &&
        body.license_activated?
    end

    def check_pricing_enterprise_cloud_mail_body(params = {})
      body = MailParseBody.new(params)
      body.full_name_match? &&
        body.email_match? &&
        body.company_name_match? &&
        body.support_level_match? &&
        body.training_courses? &&
        body.cloud_type_match?
    end

    def check_pricing_docs_developers_cloud_mail_body(params = {})
      body = MailParseBody.new(params)
      body.full_name_match? &&
        body.email_match? &&
        body.company_name_match? &&
        body.support_level_match? &&
        body.all_additional_tools_check
    end

    def check_pricing_docs_developers_premises_mail_body(params = {})
      body = MailParseBody.new(params)
      body.contact_information_check &&
        body.support_level_match? &&
        body.all_licensing_conditions_check &&
        body.multi_tenancy_support? &&
        body.recovery_support? &&
        body.branding_type_match? &&
        body.multi_server_deployment? &&
        body.all_additional_tools_check
    end

    def check_install_canceled_mail_body(params = {})
      body = MailParseBody.new(params)
      body.switched_to_the_cloud_match? &&
        body.technical_problems_match? &&
        body.necessary_features_match? &&
        body.legal_violation_match? &&
        body.rarely_use_match?
    end

    def check_account_canceled_mail_body(params = {})
      body = MailParseBody.new(params)
      body.technical_problems_match? &&
        body.storage_space_match? &&
        body.necessary_features_match? &&
        body.legal_violation_match? &&
        body.rarely_work_match?
    end

    def check_desktop_uninstalled_mail_body(params = {})
      body = MailParseBody.new(params)
      body.technical_problems_match? &&
        body.another_desktop_software_match? &&
        body.necessary_features_match? &&
        body.legal_violation_match? &&
        body.rarely_use_match?
    end

    def check_registration_canceled_mail_body(params = {})
      body = MailParseBody.new(params)
      body.switched_on_premises_match? &&
        body.switched_to_personal_match? &&
        body.technical_problems_match? &&
        body.necessary_features_match? &&
        body.legal_violation_match? &&
        body.rarely_use_match?
    end

    def extract_login_link_from_email(subject:, timeout: 60)
      sleep 120

      mail = get_email_by_subject({ subject: subject }, timeout, true)
      raise 'No email found with login link' unless mail

      html = mail[:html_body]
      raise 'Email has no HTML body' if html.nil? || html.empty?

      match = html.match(%r{<a[^>]*href="([^"]+)"[^>]*>Log in to DocSpace</a>}i)
      raise 'Login link not found in email' unless match

      CGI.unescapeHTML(match[1])
    end
  end
end
