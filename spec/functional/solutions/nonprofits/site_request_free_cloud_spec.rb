# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Request free cloud' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    non_profit_organizatins_page = site_home_page.click_link_on_toolbar(:solutions_nonprofits)
    @request_free_cloud_page = non_profit_organizatins_page.click_request_free_cloud
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][RequestFreeCloud] Check link `create your cloud office here`' do
    @sign_up_page = @request_free_cloud_page.click_create_your_cloud_office_here
    expect(@sign_up_page).to be_a TestingSiteOnlyoffice::SiteSignUp
  end

  it '[Site][RequestFreeCloud] Check link `ONLYOFFICE website`' do
    @home_page = @request_free_cloud_page.click_onlyoffice_website
    expect(@home_page).to be_a TestingSiteOnlyoffice::SiteHomePage
  end

  it '[Site][Nonprofits] Send free cloud request for nonprofit' do
    pending('https://bugzilla.onlyoffice.com/show_bug.cgi?id=43150') if config.server.include?('.com')
    last_name = "nctautotest #{Time.now}"
    @request_free_cloud_page.send_non_profit_request(last_name: last_name)
    expect(@request_free_cloud_page).to be_request_accepted
    site_admin_email = IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL)
    expect(site_admin_email.check_email_by_subject(
             { subject: TestingSiteOnlyoffice::SiteNotificationData::NON_PROFIT_REQUEST, search: last_name }, 300, true
           )).to be_truthy
  end
end
