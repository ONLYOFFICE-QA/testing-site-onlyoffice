# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'About contribute' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @about_contribute_page = site_home_page.click_link_on_toolbar(:about_contribute)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[About contribute] Go to documentation Github' do
    @about_contribute_page.open_github
    expect(@about_contribute_page.check_title_documentation_github).to be true
  end

  it '[About contribute] Go to documentation oforms' do
    @about_contribute_page.click_read_api_documentation(2)
    expect(@about_contribute_page.check_title_documentation_oforms).to be true
  end

  it '[About contribute] Go to documentation community_server' do
    @about_contribute_page.click_read_api_documentation(3)
    expect(@about_contribute_page.check_title_documentation_community_server).to be true
  end

  it '[About contribute] Go to documentation plugins' do
    @about_contribute_page.click_read_api_documentation(1)
    expect(@about_contribute_page.check_title_documentation_plagins).to be true
  end

  it '[About contribute] Go to documentation connectors' do
    expect(@about_contribute_page.check_title_documentation_connectors).to be true
  end
end
