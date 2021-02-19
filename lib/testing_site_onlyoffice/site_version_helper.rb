module TestingSiteOnlyoffice
  class SiteVersionHelper
    # @return [String] url of site
    def self.site_url
      return 'https://teamlab.info' if StaticDataTeamLab.portal_type == '.info'
      return 'https://www.onlyoffice.com' if StaticDataTeamLab.portal_type == '.com'
    end

    def self.fetch_uri
      URI("#{site_url}/revision?Site_Testing=4testing")
    end

    # @return [String] hash of site by url `site/revision`
    def self.fetch_site_hash
      Net::HTTP.get(fetch_uri).split[0]
    rescue StandardError => e
      OnlyofficeLoggerHelper.log("Cannot get site hash because of #{e}")
      Time.now.strftime('%Y-%m-%d')
    end

    # @return [String] branch number of site by url `site/revision`
    def self.fetch_site_branch
      Net::HTTP.get(fetch_uri).strip.split('/')[-1]
    rescue StandardError => e
      OnlyofficeLoggerHelper.log("Cannot get site branch number because of #{e}")
      Time.now.strftime('%Y-%m-%d')
    end

    def self.full_site_version
      "branch: #{fetch_site_branch}, hash: #{fetch_site_hash}"
    end
  end
end
