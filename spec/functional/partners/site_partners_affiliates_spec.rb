# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Partners affiliates' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @affiliates = site_home_page.click_link_on_toolbar(:partners_affiliates)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Partners affiliates] Go to Become an affiliate' do
    @affiliates.click_become_an_affiliates_button
    expected_title = 'Ascensio Systems Pte. Ltd | Sign up'
    expect(@affiliates.check_opened_page_title).to eq(expected_title)
  end

  it '[Partners affiliates] Go to Registration to affiliates' do
    @affiliates.click_registration_to_affiliates_button
    expected_title = 'Ascensio Systems Pte. Ltd | Sign up'
    expect(@affiliates.check_opened_page_title).to eq(expected_title)
  end

  it '[Partners affiliates] Go to Learn more about ONLYOFFICE DocSpace' do
    expect(@affiliates.click_learn_more_docspace).to be_a TestingSiteOnlyoffice::SiteDocSpaceMainPage
  end

  it '[Partners affiliates] Go to Solution guide and download file' do
    @affiliates.click_product_guide
    expect(@affiliates).to be_file_downloaded('onlyoffice_secure_cloud_space.pdf')
  end

  it '[Partners affiliates] Go to Marketing kit' do
    expect(@affiliates.click_marketing_kit).to be_a TestingSiteOnlyoffice::SiteAboutPressDownloads
  end

  it '[Partners affiliates] Go to Affiliate policy' do
    @affiliates.click_affiliates_policy_button
    expected_title = 'Terms of Service'
    expect(@affiliates.check_opened_page_title(switch_tab: false)).to eq(expected_title)
  end
end
