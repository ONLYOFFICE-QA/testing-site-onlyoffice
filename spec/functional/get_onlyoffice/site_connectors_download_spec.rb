require 'spec_helper'

test_manager = TestManager.new(suite_name: File.basename(__FILE__))

describe 'Connectors download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::PortalHelper.new.open_page_teamlab_office
    @connectors_page = site_home_page.click_link_on_toolbar(:open_source_packages).open_opensource_connectors
  end

  TestingSiteOnlyoffice::SiteDownloadData.connectors_list.each do |connector|
    it "[Site][DownloadConnectors]Check `#{connector}` 'Get on Github' link /download.aspx" do
      @connectors_page.get_on_github_connector(connector)
      github_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_info[connector.to_s]['github_title']
      expect(@connectors_page.check_opened_page_title).to eq(github_title)
    end

    it "[Site][DownloadConnectors]Check `#{connector}`'Read instructions' link /download.aspx" do
      @connectors_page.read_instruction_connector(connector)
      instruction_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_info[connector.to_s]['instruction_title']
      expect(@connectors_page.check_opened_page_title).to eq(instruction_title)
    end

    it "[Site][DownloadConnectors] release info for `#{connector}` on site matches github data /download.aspx" do
      site_data = TestingSiteOnlyoffice::SiteConnectorReleaseData.new(version: @connectors_page.site_version(connector),
                                                                      date: @connectors_page.site_date(connector))
      github_data = TestingSiteOnlyoffice::SiteConnectorReleaseData.new(version: @connectors_page.github_version(connector),
                                                                        date: @connectors_page.github_date(connector))
      error = @connectors_page.error_message(connector: connector, github_date: github_data.date,
                                             github_version: github_data.version, site_date: site_data.date, site_version: site_data.version)
      expect(github_data == site_data).to be_truthy, error
    end
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
