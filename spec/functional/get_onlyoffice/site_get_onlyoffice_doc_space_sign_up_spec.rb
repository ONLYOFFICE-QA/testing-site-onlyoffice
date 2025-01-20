# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe '[Site][Get Onlyoffice][Docspace Sign up]' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @docspace_sign_up = site_home_page.click_link_on_toolbar(:site_get_onlyoffice_docspace_sign_up)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][Get Onlyoffice][Docspace Sign up] Terms and conditions link works' do
    @docspace_sign_up.terms_and_conditions
    expect(@docspace_sign_up.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::DOCSPACE_TERMS)
  end

  it '[Site][Get Onlyoffice][Docspace Sign up] Privacy statement link works' do
    @docspace_sign_up.privacy_statement
    expect(@docspace_sign_up.check_opened_file_name).to eq(TestingSiteOnlyoffice::SiteNotificationData::PRIVACY_STATEMENT)
  end
end
