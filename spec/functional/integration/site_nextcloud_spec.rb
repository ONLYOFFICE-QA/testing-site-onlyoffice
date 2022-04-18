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

  it '[Nextcloud] Go to app_store' do
    expect(@nextcloud.check_link_for_nextcloud?(:nextcloud_app_store)).to be true
  end

  it '[Nextcloud] Go to git_hub' do
    expect(@nextcloud.check_link_for_nextcloud?(:nextcloud_git_hub)).to be true
  end
end
