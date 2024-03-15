# frozen_string_literal: true

shared_examples_for 'connector_download' do |connectors_list|
  connectors_list.each do |connector|
    describe connector.to_s do
      it "[Site][Connectors][#{connector}] 'Get it now' button works /all-connectors.aspx" do
        current_connector_info = connectors_page.onlyoffice_connector_block(connector)
        connectors_page.click_get_it_now_link(current_connector_info.get_it_now_xpath)
        github_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_info[connector.to_s]['website']
        expect(connectors_page.check_opened_page_title).to eq(github_title)
      end
    end
  end
end
