# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site For Business Workspace CRM' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @workspace = site_home_page.click_link_on_toolbar(:features_workspace)
    @crm = @workspace.click_on_section_link(:crm)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it "[Site][Workspace][CRM]'Check select section crm" do
    expect(@crm.check_select?('crm')).to be true
  end
end
