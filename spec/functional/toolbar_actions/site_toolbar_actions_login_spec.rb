# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site toolbar actions - log in' do
  before { @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config) }

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Login Docs Cloud button works' do
    result_page = @site_home_page.click_login_docs_cloud
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteDocsSignInPage
  end

  it 'Login DocSpace cloud button works' do
    result_page = @site_home_page.click_login_docspace_cloud
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteDocSpaceSignIn
  end

  it 'Login WorkSpace cloud button works' do
    result_page = @site_home_page.click_login_workspace_cloud
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeSignIn
  end
end
