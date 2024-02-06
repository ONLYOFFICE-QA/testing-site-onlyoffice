# frozen_string_literal: true

require 'spec_helper'

describe 'Pricing docs developer' do
  test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Site][PricingDocsDeveloper] Try it free download docs' do
    pricing_page = @site_home_page.click_link_on_toolbar(:pricing_developer)
    connectors = pricing_page.click_free_button
    expect(connectors.page_title).to eq('ONLYOFFICE Docs Developer')
  end
end
