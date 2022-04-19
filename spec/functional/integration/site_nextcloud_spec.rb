# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Nextcloud' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @nextcloud = site_home_page.click_link_on_toolbar(:integrations_nextcloud)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Nextcloud] Go to nextcloud' do
    expect(@nextcloud).to be_a TestingSiteOnlyoffice::SiteNextcloud
  end

  it '[Nextcloud] Go to get it now' do
    expect(@nextcloud.check_link_get_it_now).to be_a TestingSiteOnlyoffice::SiteDocsEnterprise
  end

  it '[Nextcloud] Go to get onlyoffice now' do
    expect(@nextcloud.check_link_get_onlyoffice_now).to be_a TestingSiteOnlyoffice::SiteDocsEnterprise
  end

  it '[Nextcloud] Go to download for desktop' do
    expect(@nextcloud.check_link_download_for_desktop).to be_a TestingSiteOnlyoffice::SiteProductsDesktop
  end

  it '[Nextcloud] Go to pick your price' do
    business_price = @nextcloud.check_link_pick_your_price
    expect(business_price.check_active_tariff('business')).to be true
  end

  it '[Nextcloud] Go to home tariff' do
    business_price = @nextcloud.check_link_home_tariff
    expect(business_price.check_active_tariff('home')).to be true
  end

  it '[Nextcloud] Go to apps_store' do
    expect(@nextcloud.check_link_for_nextcloud?(:nextcloud_apps_store)).to be true
  end

  it '[Nextcloud] Go to git_hub' do
    expect(@nextcloud.check_link_for_nextcloud?(:nextcloud_git_hub)).to be true
  end

  it '[Nextcloud] Go to app_store' do
    expect(@nextcloud.check_link_for_nextcloud?(:nextcloud_app_store)).to be true
  end

  it '[Nextcloud] Go to google_play' do
    expect(@nextcloud.check_link_for_nextcloud?(:nextcloud_google_play)).to be true
  end
end
