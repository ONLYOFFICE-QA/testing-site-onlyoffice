# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site products workspace projects' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @projects = site_home_page.click_link_on_toolbar(:products_workspace_projects)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it "[Site][Products][Projects]'Check select section projects" do
    expect(@projects.check_select?('projects')).to be true
  end
end
