# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Method for getting full portal name
  module PortalVersion
    def get_full_portal_name(portal_to_create)
      portal_domain_region = if config.server.include?('teamlab')
                               'teamlab.info'
                             elsif config.server.include?('onlyoffice') && config.region == 'us'
                               'onlyoffice.co'
                             elsif config.server.include?('onlyoffice') && config.region != 'us'
                               "onlyoffice.#{config.region}"
                             end
      "https://#{portal_to_create}.#{portal_domain_region}"
    end
  end
end
