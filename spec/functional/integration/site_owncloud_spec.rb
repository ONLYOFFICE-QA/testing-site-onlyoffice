# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'OwnCloud' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @owncloud = site_home_page.click_link_on_toolbar(:integrations_owncloud)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[OwnCloud] Go to OwnCloud' do
    expect(@owncloud).to be_a TestingSiteOnlyoffice::SiteOwnCloud
  end

  it '[OwnCloud] Go to git_hub' do
    expect(@owncloud.check_link_for_integration?(:integration_git_hub)).to be true
  end

  it '[OwnCloud] Go to app_store' do
    expect(@owncloud.check_link_for_integration?(:integration_app_store)).to be true
  end

  it '[OwnCloud] Go to google_play' do
    expect(@owncloud.check_link_for_integration?(:integration_google_play)).to be true
  end

  it '[OwnCloud] Go to pick your price' do
    business_price = @owncloud.check_link_pick_your_price
    expect(business_price.check_active_tariff?('business')).to be true
  end

  it '[OwnCloud] Go to home tariff' do
    business_price = @owncloud.check_link_home_tariff
    expect(business_price.check_active_tariff?('home')).to be true
  end
end
