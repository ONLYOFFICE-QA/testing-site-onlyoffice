# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Nextcloud' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @integration = site_home_page.click_link_on_toolbar(:integrations_nextcloud)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Nextcloud] Go to nextcloud' do
    expect(@integration).to be_a TestingSiteOnlyoffice::SiteNextcloud
  end

  it '[Nextcloud] Go to get it now' do
    expect(@integration.check_link_get_it_now).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end

  it '[Nextcloud] Go to get onlyoffice now' do
    expect(@integration.check_link_get_onlyoffice_now).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end

  it '[Nextcloud] Go to download for desktop' do
    expect(@integration.check_link_download_for_desktop).to be_a TestingSiteOnlyoffice::SiteFeaturesDesktop
  end

  it '[Nextcloud] Go to apps_store' do
    expect(@integration.check_link_for_integration?(:nextcloud_apps_store)).to be true
  end

  it '[Nextcloud] Go to git_hub' do
    expect(@integration.check_link_for_integration?(:integration_git_hub)).to be true
  end

  it '[Nextcloud] Go to app_store' do
    expect(@integration.check_link_for_integration?(:integration_app_store)).to be true
  end

  it '[Nextcloud] Go to google_play' do
    expect(@integration.check_link_for_integration?(:integration_google_play)).to be true
  end

  describe 'Pick price' do
    it_behaves_like 'integration_pick_price' do
      let(:integration_pick_price) { @integration }
    end
  end
end
