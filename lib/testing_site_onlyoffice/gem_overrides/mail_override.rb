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
        body.phone_number_match? &&
        body.company_name_match? &&
        body.support_level_match? &&
        body.training_courses? &&
        body.cloud_type_match?
    end

    def check_pricing_docs_developers_cloud_mail_body(params = {})
      body = MailParseBody.new(params)
      body.full_name_match? &&
        body.email_match? &&
        body.phone_number_match? &&
        body.company_name_match? &&
        body.support_level_match? &&
        body.access_to_api? &&
        body.live_viewer? &&
        body.mobile_apps? &&
        body.desktop_apps? &&
        body.training_courses?
    end
  end
end
