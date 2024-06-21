# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Install canceled feedback page' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @install_canceled_page = site_home_page.open_install_canceled
    @username = TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL
    @mail = OnlyofficeIredmailHelper::IredMailHelper.new(username: @username)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Check e-mail from Install canceled feedback page /install-canceled.aspx' do
    skip 'Cannot test email notifications in production' if config.server.include?('.com')
    @install_canceled_page.select_options_install_canceled(cloud_version: true, technical_problems: true, necessary_features: true, legal_violation: true, rarely_use: true)
    @install_canceled_page.send_feedback_email_install_canceled
    mail_subject = 'Request from: install-canceled'
    expect(@mail.check_install_canceled_mail_body(username: @username,
                                                  subject: mail_subject,
                                                  cloud_version: true,
                                                  technical_problems: true,
                                                  necessary_features: true,
                                                  legal_violation: true,
                                                  rarely_use: true,
                                                  move_out: true)).to be_truthy
  end

  describe 'Checks SLA and Privacy links' do
    let(:page) { @install_canceled_page }

    it_behaves_like 'check_sla_and_privacy_links'
  end
end
