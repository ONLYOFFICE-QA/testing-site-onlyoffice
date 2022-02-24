# frozen_string_literal: true

require 'csv'

module TestingSiteOnlyoffice
  # Methods for checking admins mail notifications
  class SiteNotificationHelper
    def self.site_translate_from_resource(language, string_name, tm_module)
      file_path = File.absolute_path('lib/testing_site_onlyoffice/data/site_translates.csv')
      SiteNotificationHelper.get_csv_match(file_path, language, string_name, tm_module)
    end

    def self.check_site_notification(params = {})
      expected_string = SiteNotificationHelper.site_translate_from_resource(params[:language], params[:pattern],
                                                                            params[:module])
      OnlyofficeLoggerHelper.log("expected string: #{expected_string}")
      params[:mail].check_email_by_subject({ subject: expected_string,
                                             search: params[:search] },
                                           params[:times] = params.fetch(:times, 300),
                                           params[:move_out] = params.fetch(:move_out, false))
    end

    def self.confirmation_registration_link(params = {})
      expected_string = SiteNotificationHelper.site_translate_from_resource(params[:language], params[:pattern],
                                                                            params[:module])
      mail = params[:mail].get_email_by_subject({ subject: expected_string,
                                                  search: params[:search] },
                                                params[:times] = params.fetch(:times, 300),
                                                params[:move_out] = params.fetch(:move_out, true))

      raise "Didn't find any messages with title `#{expected_string}`" unless mail

      mail[:html_body].split('href="').grep(/confirm.aspx/)[0].split('"')[0]
    end

    def self.get_csv_match(file_path, language, string_name, tm_module)
      CSV.foreach(file_path, encoding: 'UTF-8') do |row|
        return row[3] if row[2] == string_name && row[1] == language && row[0] == tm_module
      end
      language = 'Neutral'
      CSV.foreach(file_path, encoding: 'UTF-8') do |row|
        return row[3] if row[2] == string_name && row[1] == language && row[0] == tm_module
      end
      raise "String #{string_name} not found on language #{language}"
    end
  end
end
