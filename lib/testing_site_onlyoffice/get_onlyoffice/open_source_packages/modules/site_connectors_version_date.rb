# Gets Release date and Version of connectors on both site and Github

module TestingSiteOnlyffice
  module SiteConnectorsVersionDate
    def get_connector_version_xpath(connector)
      "#{instruction_links[connector].selector[:xpath]}/../../p[1]"
    end

    def get_connector_release_date_xpath(connector)
      "#{instruction_links[connector].selector[:xpath]}/../../p[2]"
    end

    def site_version(connector)
      @instance.webdriver.get_text(get_connector_version_xpath(connector)).split[1]
    end

    def site_date(connector)
      date = @instance.webdriver.get_text(get_connector_release_date_xpath(connector)).split[2]
      Date.strptime(date, '%m/%d/%Y')
    end

    def github_data_json(connector)
      link = "https://api.github.com/repos/ONLYOFFICE/onlyoffice-#{connector}/releases/latest"
      response = HTTParty.get(link)
      JSON.parse(response.to_s)
    end

    def github_version(connector)
      github_data_json(connector)['tag_name'].delete('v')
    end

    def github_date(connector)
      Date.parse(github_data_json(connector)['published_at'])
    end

    def error_message(params = {})
      "url: #{@instance.webdriver.driver.current_url}\n" \
    "Release info about #{params[:connector]} connector on site != github data\n" \
    "github's version: #{params[:github_version]} release date #{params[:github_date]}\n" \
    "site's version: #{params[:site_version]} release date #{params[:site_date]}\n"
    end
  end
end
