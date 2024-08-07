# frozen_string_literal: true

shared_examples_for 'connector_download' do |connectors_list|
  connectors_list.each do |connector|
    describe connector.to_s do
      it "[Site][Connectors][#{connector}] 'Get it now' button works /all-connectors.aspx" do
        current_connector_info = connectors_page.onlyoffice_connector_block(connector)
        connectors_page.click_get_it_now_link(current_connector_info.get_it_now_xpath)
        if connector.to_s == 'zoom'
          possible_titles = ['App Marketplace', 'ONLYOFFICE DocSpace']
          expect(possible_titles).to include(connectors_page.check_opened_page_title)
        elsif connector.to_s == 'box'
          possible_titles = ['ONLYOFFICE Docs | Box App Center', 'ONLYOFFICE Docs | Box App Center | Powered by Box']
          expect(possible_titles).to include(connectors_page.check_opened_page_title)
        else
          github_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_info[connector.to_s]['get_it_now']
          expect(connectors_page.check_opened_page_title_and_wait_until_not_empty).to eq(github_title)
        end
      end
    end
  end
end
