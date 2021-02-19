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
    end

    # @return [String] branch number of site by url `site/revision`
    def self.fetch_site_branch
      Net::HTTP.get(fetch_uri).strip.split('/')[-1]
    end
  end
end
