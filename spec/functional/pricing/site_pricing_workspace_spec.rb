# frozen_string_literal: true

require 'spec_helper'

describe 'Pricing WorkSpace' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @pricing_workspace_page = site_home_page.click_link_on_toolbar(:pricing_workspace)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][Pricing][WorkSpace] Check "Try it for free 30 days" link' do
    workspace_download_page = @pricing_workspace_page.click_try_free
    expect(workspace_download_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeWorkspaceEnterprise
  end

end
