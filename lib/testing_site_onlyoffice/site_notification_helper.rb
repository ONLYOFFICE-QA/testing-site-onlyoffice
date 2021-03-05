require 'csv'

module TestingSiteOnlyoffice
  class SiteNotificationHelper < NotificationHelper
    def self.site_translate_from_resource(language, string_name, tm_module)
      file_path = File.absolute_path('lib/testing_site_onlyoffice/data/site_translates.csv')
      get_csv_match(file_path, language, string_name, tm_module)
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
      mail[:html_body].split('href="').grep(/confirm.aspx/)[0].split('"')[0]
    end
  end
end
