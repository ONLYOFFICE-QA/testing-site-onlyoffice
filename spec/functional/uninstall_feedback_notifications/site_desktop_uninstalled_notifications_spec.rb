# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Desktop uninstall feedback page' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @desktop_uninstalled_page = site_home_page.open_desktop_uninstalled
    @username = TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL
    @mail = OnlyofficeIredmailHelper::IredMailHelper.new(username: @username)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Check e-mail from Desktop uninstalled feedback page /desktop-uninstalled.aspx' do
    skip 'Cannot test email notifications in production' if config.server.include?('.com')
    @desktop_uninstalled_page.select_options_desktop_uninstalled(technical_problems: true, another_desktop_software: true, necessary_features: true, legal_violation: true, rarely_use: true)
    @desktop_uninstalled_page.send_feedback_email_desktop_uninstalled
    mail_subject = 'Request from: desktop-uninstalled'
    expect(@mail.check_desktop_uninstalled_mail_body(username: @username,
                                                     subject: mail_subject,
                                                     technical_problems: true,
                                                     another_desktop_software: true,
                                                     necessary_features: true,
                                                     legal_violation: true,
                                                     rarely_use: true,
                                                     move_out: true)).to be_truthy
  end

  describe 'Checks SLA and Privacy links' do
    let(:page) { @desktop_uninstalled_page }

    it_behaves_like 'check_sla_and_privacy_links'
  end
end
