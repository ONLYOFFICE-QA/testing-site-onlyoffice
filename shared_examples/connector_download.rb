# frozen_string_literal: true

shared_examples_for 'connector_download' do |connectors_list|
  connectors_list.each do |connector|
    describe connector.to_s do
      before do
        @current_installation = connectors_page.installer_open_source_connector_block(connector)
      end

      it "[Site][Connectors][#{connector}] 'Get on Github' button works /download-connectors.aspx" do
        connectors_page.click_constructor_link(@current_installation.get_on_github_xpath)
        github_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_info[connector.to_s]['github']
        expect(connectors_page.check_opened_page_title).to eq(github_title)
      end
    end
  end
end
