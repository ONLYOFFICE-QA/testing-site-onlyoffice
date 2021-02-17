# frozen_string_literal: true

require_relative '../../../../TeamLab/Framework/TestInstance'

module TestingSiteOnlyoffice
  class SiteData
    EMAIL_FOR_SITE = 'site@qamail.teamlab.info'
    PORTAL_ADDRESS_COM = 'https://nctautotest-notifications-site-com.onlyoffice.com'
    PORTAL_ADDRESS_EU = 'https://nctautotest-notifications-site-eu.onlyoffice.eu'
    PORTAL_ADDRESS_SG = 'https://nctautotest-notifications-site-sg.onlyoffice.sg'
    PORTAL_ADDRESS_INFO = 'https://nctautotest-site-notifications.teamlab.info'

    PORTAL_ADDRESS = if StaticDataTeamLab.portal_type == '.info'
                       PORTAL_ADDRESS_INFO
                     else
                       case StaticDataTeamLab.server_region
                       when 'us'
                         PORTAL_ADDRESS_COM
                       when 'eu'
                         PORTAL_ADDRESS_EU
                       when 'sg'
                         PORTAL_ADDRESS_SG
                       else
                         raise "Doesn't exist region=#{StaticDataTeamLab.server_region}"
                       end
                     end

    def self.site_languages
      case StaticDataTeamLab.portal_type
      when '.com'
        %w[en-US en-GB ru-RU fr-FR de-DE es-ES pt-BR it-IT cs-CZ nl-NL ja-JP zh-CN]
      when '.info'
        %w[en-US en-GB de-DE fr-FR es-ES ru-RU pt-BR it-IT cs-CZ nl-NL ja-JP zh-CN]
      end
    end
  end
end
