# frozen_string_literal: true

shared_examples_for 'connector_download' do |connectors_list|
  connectors_list.each do |connector|
    describe connector.to_s do
      before do
        @current_installation = connectors_page.installer_open_source_connector_block(connector)
      end

      it "[Site][OtherProducts][Connectors][#{connector}] 'Get on Github' button works /download.aspx#connectors" do
        connectors_page.click_constructor_link(@current_installation.get_on_github_xpath)
        github_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_info[connector.to_s]['github']
        expect(connectors_page.check_opened_page_title).to eq(github_title)
      end

      it "[Site][OtherProducts][Connectors][#{connector}] 'Read installation' button works /download.aspx#connectors" do
        connectors_page.click_constructor_link(@current_installation.instruction_xpath)
        instruction_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_info[connector.to_s]['instruction']
        expect(connectors_page.check_opened_page_title).to eq(instruction_title)
      end

      it "[Site][OtherProducts][Connectors][#{connector}]release info on site matches github data /download.aspx#connectors" do
        site_data = TestingSiteOnlyoffice::SiteConnectorReleaseData.new(version: connectors_page.get_installer_release_date_or_version(@current_installation.version_xpath),
                                                                        date: connectors_page.get_installer_release_date_or_version(@current_installation.release_date_xpath))
        github_data = TestingSiteOnlyoffice::SiteConnectorReleaseData.new(version: connectors_page.github_version(connector),
                                                                          date: connectors_page.github_date(connector))
        error = connectors_page.error_version_message(connector:, github_date: github_data.date,
                                                      github_version: github_data.version, site_date: site_data.date, site_version: site_data.version)
        expect(github_data == site_data).to be_truthy, error
      end
    end
  end
end
