# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Partners - Technology partners' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @partners_technology = site_home_page.click_link_on_toolbar(:partners_technology)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Partners] [Technology Partners] Become partner button works' do
    result_page = @partners_technology.click_become_partner_button
    expect(result_page).to be_a TestingSiteOnlyoffice::SitePartnersRequest
  end

  it '[Partners] [Technology Partners] Doc editors "Try now" button works' do
    result_page = @partners_technology.click_docs_dev_try_now
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper
  end

  it '[Partners] [Technology Partners] Doc builder "Download now" button works' do
    result_page = @partners_technology.click_doc_builder_download
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDownloadDocBuilder
  end

  TestingSiteOnlyoffice::SiteDownloadData.partners_os_distributions_list.each do |distro|
    describe distro.to_s do
      it "[Partners] [Technology Partners] [OS distributions] #{distro} link works" do
        current_distro_link = @partners_technology.get_partner_link(distro)
        expect(@partners_technology).to be_link_success_response(current_distro_link)
      end
    end
  end

  TestingSiteOnlyoffice::SiteDownloadData.partners_marketplaces_list.each do |market|
    describe market.to_s do
      it "[Partners] [Technology Partners] [Marketplaces] #{market} link works" do
        current_mp_link = @partners_technology.get_partner_link(market)
        expect(@partners_technology).to be_link_success_response(current_mp_link)
      end
    end
  end
end
