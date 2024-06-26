# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Account canceled page' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @account_canceled_page = site_home_page.open_account_canceled
    @username = TestingSiteOnlyoffice::SiteData::PARTNERS_EMAIL
    @mail = OnlyofficeIredmailHelper::IredMailHelper.new(username: @username)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Check e-mail from Account canceled with all options selected /account-canceled.aspx' do
    skip 'Cannot test email notifications in production' if config.server.include?('.com')
    @account_canceled_page.select_options_account_canceled(technical_problems: true, storage_space: true, necessary_features: true, legal_violation: true, rarely_work: true)
    @account_canceled_page.send_feedback_email_account_canceled
    mail_subject = 'Request from: account-canceled'
    expect(@mail.check_account_canceled_mail_body(username: @username,
                                                  subject: mail_subject,
                                                  technical_problems: true,
                                                  storage_space: true,
                                                  necessary_features: true,
                                                  legal_violation: true,
                                                  rarely_work: true,
                                                  move_out: true)).to be_truthy
  end

  it 'Check e-mail from Account canceled with one default option selected /account-canceled.aspx' do
    skip 'Cannot test email notifications in production' if config.server.include?('.com')
    @account_canceled_page.select_options_account_canceled(technical_problems: false, storage_space: false, necessary_features: false, legal_violation: false, rarely_work: false)
    @account_canceled_page.send_feedback_email_account_canceled
    mail_subject = 'Request from: account-canceled'
    expect(@mail.check_account_canceled_mail_body(username: @username,
                                                  subject: mail_subject,
                                                  technical_problems: false,
                                                  storage_space: false,
                                                  necessary_features: false,
                                                  legal_violation: false,
                                                  rarely_work: false,
                                                  move_out: true)).to be_truthy
  end


  describe 'Checks SLA and Privacy links' do
    let(:page) { @account_canceled_page }

    it_behaves_like 'check_sla_and_privacy_links'
  end
end
