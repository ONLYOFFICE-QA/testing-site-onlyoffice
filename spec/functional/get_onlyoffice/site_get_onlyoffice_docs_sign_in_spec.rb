# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
incorrect_email = TestingSiteOnlyoffice::DocsRegistrationData.new.generate_incorrect_data.doc_email

describe 'Docs Enterprise Sign In page' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @docs_sign_in_page = site_home_page.click_link_on_toolbar(:get_onlyoffice_docs_sign_in)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Failed login to Docs cloud with incorrect e-mail' do
    @docs_sign_in_page.input_email_and_submit(incorrect_email)
    expect(@docs_sign_in_page.email_error_visible?).to be true
  end

  it 'See SLA link works' do
    @docs_sign_in_page.sla_link
    expect(@docs_sign_in_page.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::SERVICE_LEGAL_AGREEMENT)
  end

  it 'See Privacy statement link works' do
    @docs_sign_in_page.privacy_statement
    expect(@docs_sign_in_page.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::PRIVACY_STATEMENT)
  end

  it 'Register from sign in page works' do
    result_page = @docs_sign_in_page.register_from_sign_in_page
    expect(result_page).to be_a TestingSiteOnlyoffice::DocsRegistrationPage
  end
end
