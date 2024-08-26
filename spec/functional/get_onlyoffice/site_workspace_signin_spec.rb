# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
mail_site = OnlyofficeIredmailHelper::IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::EMAIL_FOR_SITE)
checker = { language: config.language, module: 'WebStudio' }

describe 'Workspace sign in' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @workspace_sign_in_page = @site_home_page.click_login_workspace_cloud
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Check mail "Forgot password"' do
    @workspace_sign_in_page.send_forgot_password(TestingSiteOnlyoffice::SiteData::EMAIL_FOR_SITE)
    expect(TestingSiteOnlyoffice::SiteNotificationHelper.check_site_notification(checker.merge(mail: mail_site,
                                                                                               pattern: 'teamlab_pwd_reminder',
                                                                                               search: TestingSiteOnlyoffice::SiteData.site_notification_page))).to be_truthy
  end

  it 'Sign in with wrong data' do
    @workspace_sign_in_page.sign_in('1', '2')
    expect(@workspace_sign_in_page.sign_in_error_element).to be_present
  end

  TestingSiteOnlyoffice::SiteData.sign_in_with_network_list.each do |network|
    it "Sign in with #{network} window opened" do
      skip if network == :linkedin && config.server.include?('.info')
      sign_in_with_page = @workspace_sign_in_page.sign_in_with(network)
      expect(sign_in_with_page).to be_indicator_element_present(network)
    end
  end
end
