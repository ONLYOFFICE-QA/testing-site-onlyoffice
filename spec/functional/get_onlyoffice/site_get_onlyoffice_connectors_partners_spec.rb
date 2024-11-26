# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Connectors partners download' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @connectors_page = site_home_page.click_link_on_toolbar(:features_connectors)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it "[Site][Get Onlyoffice][Connectors] Connectors partners number didn't change" do
    expect(@connectors_page.connectors_block_number(:partners)).to eq(TestingSiteOnlyoffice::SiteDownloadData.connectors_partners_info.keys.count)
  end

  it '[Site][Get Onlyoffice][Connectors] Filter by partners developers works' do
    @connectors_page.select_partners_developers
    expect(@connectors_page.verify_elements_hidden(:onlyoffice)).to be_truthy
  end

  TestingSiteOnlyoffice::SiteDownloadData.connectors_partners_info.each_key do |connector|
    describe connector.to_s do
      let(:current_connector) { @connectors_page.connectors_partners_block(connector) }

      it "[Site][Get Onlyoffice][PartnerConnectors][#{connector}] 'More info' link works /all-connectors.aspx" do
        @connectors_page.click_partners_more_info_link(current_connector.more_info_xpath)
        more_info_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_partners_info[connector.to_s]['more_info']
        # Added a status code check for the WeDoc connector due to an empty page title
        if connector.to_s == 'wedoc'
          wedoc_more_info_link = @connectors_page.get_connector_info_link(current_connector.more_info_xpath)
          expect(@connectors_page).to be_link_success_response(wedoc_more_info_link)
        else
          expect(@connectors_page.check_opened_page_title_and_wait_until_not_empty).to eq(more_info_title)
        end
      end

      it "[Site][Get Onlyoffice][PartnerConnectors][#{connector}] Developer website link works /all-connectors.aspx" do
        @connectors_page.click_developers_site_link(current_connector.developer_website_xpath)
        developer_website_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_partners_info[connector.to_s]['website']
        expect(@connectors_page.check_opened_page_title_and_wait_until_not_empty).to eq(developer_website_title)
      end

      it "[Site][Connectors][#{connector}] 'Get it now' button works /all-connectors.aspx" do
        @connectors_page.click_get_it_now_link(current_connector.get_it_now_xpath)
        get_it_now_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_partners_info[connector.to_s]['get_it_now']
        # Added a status code check for the WeDoc connector due to an empty page title
        if connector.to_s == 'wedoc'
          wedoc_get_it_now_link = @connectors_page.get_connector_info_link(current_connector.get_it_now_xpath)
          expect(@connectors_page).to be_link_success_response(wedoc_get_it_now_link)
        else
          expect(@connectors_page.check_opened_page_title_and_wait_until_not_empty).to eq(get_it_now_title)
        end
      end
    end
  end
end
