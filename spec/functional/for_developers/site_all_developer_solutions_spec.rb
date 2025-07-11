# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Developers - All Developer Solutions' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @all_developer_solutions = site_home_page.click_link_on_toolbar(:for_developers_all_solutions)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test&.webdriver&.quit
  end

  it '[Developers] [All Developer Solutions] Docspace "API" link works' do
    @all_developer_solutions.click_docspace_api
    expect(@all_developer_solutions.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::DOCSPACE_TITLE)
  end

  it '[Developers] [All Developer Solutions] Docs "Open wopi support" link works' do
    expect(@all_developer_solutions.click_docs_open_wopi).to be_a TestingSiteOnlyoffice::SiteWOPIComparison
  end

  it '[Developers] [All Developer Solutions] Docs "Open api support" link works' do
    @all_developer_solutions.click_docs_open_api
    expect(@all_developer_solutions.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::ONLYOFFICE_API_TITLE)
  end

  it '[Developers] [All Developer Solutions] Docs "learn more" link works' do
    expect(@all_developer_solutions.click_docs_learn_more).to be_a TestingSiteOnlyoffice::SiteForDevelopersDocDevEdition
  end

  it '[Developers] [All Developer Solutions] Docbuilder "Check examples" link works' do
    @all_developer_solutions.click_docbuilder_read_documentaion
    expected_title = 'ONLYOFFICE'
    expect(@all_developer_solutions.check_opened_page_title).to eq(expected_title)
  end

  it '[Developers] [All Developer Solutions] "Available plugins" link works' do
    expect(@all_developer_solutions.click_available_plugins).to be_a TestingSiteOnlyoffice::SiteFeaturesMarketplace
  end
end
