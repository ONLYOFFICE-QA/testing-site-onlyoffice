# frozen_string_literal: true

module TestingSiteOnlyoffice
  class SiteData
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
      if config.server.include?('.com')
        %w[en-US en-GB ru-RU fr-FR de-DE es-ES pt-BR it-IT cs-CZ nl-NL ja-JP zh-CN]
      elsif config.server.include?('.info')
        %w[en-US en-GB de-DE fr-FR es-ES ru-RU pt-BR it-IT cs-CZ nl-NL ja-JP zh-CN]
      end
    end
  end
end
