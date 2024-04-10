# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
docspace_client_email = TestingSiteOnlyoffice::SiteData::CLIENT_EMAIL
docspace_client_password = TestingSiteOnlyoffice::SiteData::DOCSPACE_PASSWORD
client_email_to_check = OnlyofficeIredmailHelper::IredMailHelper.new(username: TestingSiteOnlyoffice::SiteData::CLIENT_EMAIL)

describe '[Site][Get Onlyoffice][Docspace Sign in]' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @docspace_sign_in = site_home_page.click_link_on_toolbar(:get_onlyoffice_docspace_sign_in)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][Get Onlyoffice][Docspace Sign in] Login to DocSpace' do
    pending('because of domains connection specifics') if config.server.include?('teamlab.info')
    result_page = @docspace_sign_in.email_and_password_submit(email: docspace_client_email, password: docspace_client_password)
    expect(result_page).to be_a TestingSiteOnlyoffice::DocSpaceMainPage
  end

  it '[Site][Get Onlyoffice][Docspace Sign in] Register from sign_in link works' do
    result_page = @docspace_sign_in.register_from_sign_in
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignUp
  end

  it '[Site][Get Onlyoffice][Docspace Sign in] Restore password works' do
    @docspace_sign_in.restore_password_from_sign_in(docspace_client_email)
    expect(client_email_to_check.check_email_by_subject({ subject: 'ONLYOFFICE Password Reminder' }, 300, true)).to be true
  end
end
