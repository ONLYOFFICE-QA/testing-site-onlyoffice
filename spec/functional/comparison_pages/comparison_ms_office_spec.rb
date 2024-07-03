# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Comparison - ONLYOFFICE Docs vs MS Office Online' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @ms_office_comparison = site_home_page.click_oo_docs_vs_ms_office
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Comparison][MS Office] Watch presentation' do
    @ms_office_comparison.click_watch_presentation
    expect(@ms_office_comparison.check_opened_file_name).to eq 'ONLYOFFICE vs Microsoft Office Online.pptx'
  end

  it '[Comparison][MS Office] Read instruction' do
    @ms_office_comparison.click_read_instruction
    expect(@ms_office_comparison.check_opened_file_name).to eq 'How to compare online editors.pdf'
  end

  it '[Comparison][MS Office] "Get onlyoffice docs" now button works' do
    result_page = @ms_office_comparison.click_get_onlyoffice_docs
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end

  it '[Comparison][MS Office] "Try in the cloud" button works' do
    result_page = @ms_office_comparison.click_try_in_the_cloud
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
  end

  it '[Comparison][MS Office] "Private Room" link works' do
    result_page = @ms_office_comparison.click_private_room
    expect(result_page).to be_a TestingSiteOnlyoffice::DocspacePrivateRooms
  end
end
