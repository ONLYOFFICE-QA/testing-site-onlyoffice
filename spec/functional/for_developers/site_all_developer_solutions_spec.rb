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
    expect(@all_developer_solutions.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::DOCSPACE_API_TITLE)
  end

  it '[Developers] [All Developer Solutions] Docs "Open wopi support" link works' do
    expect(@all_developer_solutions.click_docs_open_wopi).to be_a TestingSiteOnlyoffice::SiteWOPIComparison
  end

  it '[Developers] [All Developer Solutions] Docs "Open api support" link works' do
    @all_developer_solutions.click_docs_open_api
    expect(@all_developer_solutions.check_opened_page_title).to eq(TestingSiteOnlyoffice::SiteDownloadData::OVERVIEW_API_ONLYOFFICE_TITLE)
  end

  it '[Developers] [All Developer Solutions] Docs "learn more" link works' do
    expect(@all_developer_solutions.click_docs_learn_more).to be_a TestingSiteOnlyoffice::SiteForDevelopersDocDevEdition
  end

  it '[Developers] [All Developer Solutions] Docbuilder "Download Now" link works' do
    expect(@all_developer_solutions.click_docbuilder_download_now).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsDeveloper
  end

  it '[Developers] [All Developer Solutions] Docbuilder "Source code" link works' do
    @all_developer_solutions.click_docbuilder_source_code
    expected_title = 'GitHub - ONLYOFFICE/DocumentBuilder: ONLYOFFICE Document Builder is powerful text, spreadsheet, presentation and PDF generating tool'
    expect(@all_developer_solutions.check_opened_page_title).to eq(expected_title)
  end

  it '[Developers] [All Developer Solutions] Docbuilder "Check examples" link works' do
    @all_developer_solutions.click_docbuilder_check_examples
    expected_title = 'Overview - ONLYOFFICE Api Documentation'
    expect(@all_developer_solutions.check_opened_page_title).to eq(expected_title)
  end

  it '[Developers] [All Developer Solutions] "Available plugins" link works' do
    expect(@all_developer_solutions.click_available_plugins).to be_a TestingSiteOnlyoffice::SiteFeaturesMarketplace
  end

  it '[Developers] [All Developer Solutions] Workspace "Find out more" link works' do
    @all_developer_solutions.click_workspace_find_out_more
    expected_title = 'API Backend - ONLYOFFICE Api Documentation'
    expect(@all_developer_solutions.check_opened_page_title).to eq(expected_title)
  end
end
