# frozen_string_literal: true

require 'spec_helper'

describe 'Pricing docs home server' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @pricing_docs_home = @site_home_page.click_link_on_toolbar(:pricing_docs_home_server)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][Pricing][Docs Home server] Try it free link works' do
    result_page = @pricing_docs_home.click_try_free_docs
    expect(result_page).to be_a TestingSiteOnlyoffice::SiteGetOnlyofficeDocsEnterprise
  end
end
