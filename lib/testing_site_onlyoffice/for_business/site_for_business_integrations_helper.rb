# frozen_string_literal: true

require_relative 'alfresco/site_alfresco'
require_relative 'confluence/site_confluence'
require_relative 'moodle/site_moodle'
require_relative 'nextcloud/site_nextcloud'
require_relative 'owncloud/site_owncloud'

module TestingSiteOnlyoffice
  # Helper methods for integrations specs in For Business section
  module ForBusinessIntegrationsHelper

    def self.integrations_list
      {
        for_business_nextcloud: {
          class: SiteNextcloud
        },
        for_business_alfresco: {
          class: SiteAlfresco
        },
        for_business_owncloud: {
          class: SiteOwnCloud
        },
        for_business_confluence: {
          class: SiteConfluence
        },
        for_business_moodle: {
          class: SiteMoodle
        }
      }
    end
  end
end
