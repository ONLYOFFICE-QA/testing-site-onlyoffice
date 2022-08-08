# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site products connectors' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @products_connectors_page = site_home_page.footer_nonprofits.click_see_all_integrations
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][Products][Connectors] Button "Get Onlyoffice Docs" works' do
    commercial_docs_page = @products_connectors_page.get_onlyoffice_docs
    expect(commercial_docs_page).to be_a TestingSiteOnlyoffice::SiteDocsEnterprise
  end

  TestingSiteOnlyoffice::SiteDownloadData.connectors_partners_list.each do |connector|
    describe connector.to_s do
      let(:products_connectors_partners_page) { @products_connectors_page.switch_to_provided_by_partners }
      let(:current_connector) { products_connectors_partners_page.partners_connector_block(connector) }

      it "[Site][Products][PartnerConnectors][#{connector}] 'More info' link works /all-connectors.aspx" do
        products_connectors_partners_page.click_constructor_link(current_connector.more_info_xpath)
        more_info_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_partners_info[connector.to_s]['more_info']
        expect(products_connectors_partners_page.check_opened_page_title).to eq(more_info_title)
      end

      it "[Site][Products][PartnerConnectors][#{connector}] Developer website link works /all-connectors.aspx" do
        pending('maarch site has expired certificate') if connector == :maarch
        products_connectors_partners_page.click_constructor_link(current_connector.developer_website_xpath)
        developer_website_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_partners_info[connector.to_s]['website']
        expect(products_connectors_partners_page.check_opened_page_title).to eq(developer_website_title)
      end

      it "[Site][Products][PartnerConnectors][#{connector}] 'Get it now' button works /all-connectors.aspx" do
        products_connectors_partners_page.click_constructor_link(current_connector.get_it_now_xpath)
        get_it_now_title = TestingSiteOnlyoffice::SiteDownloadData.connectors_partners_info[connector.to_s]['get_it_now']
        expect(products_connectors_partners_page.check_opened_page_title).to eq(get_it_now_title)
      end
    end
  end
end
