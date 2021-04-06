module TestingSiteOnlyoffice
  class SiteVersionHelper
    def self.fetch_uri
      URI("#{config.server}/revision?Site_Testing=4testing")
    end

    # @return [String] hash of site by url `site/revision`
    def self.fetch_site_hash
      Net::HTTP.get(fetch_uri).split[0]
    rescue StandardError => e
      OnlyofficeLoggerHelper.log("Cannot get site hash because of #{e}")
      'unknown'
    end

    # @return [String] branch number of site by url `site/revision`
    def self.fetch_site_branch
      Net::HTTP.get(fetch_uri).strip.split('/')[-1]
    rescue StandardError => e
      OnlyofficeLoggerHelper.log("Cannot get site branch number because of #{e}")
      'unknown'
    end

    def self.full_site_version
      "branch: #{fetch_site_branch}, hash: #{fetch_site_hash}"
    end
  end
end
