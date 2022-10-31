# frozen_string_literal: true

require_relative '../modules/site_toolbar'

module TestingSiteOnlyoffice
  class ForBusinessHelper

    def initialize(integration)
      @integration = integration
    end

    def self.integrations_list
      {
        list: %i[for_business_nextcloud for_business_alfresco for_business_owncloud for_business_confluence for_business_moodle]
      }
    end

    def class_from_integration_list
      site_toolbar_for_business[@integration][:class]
    end
  end
end
