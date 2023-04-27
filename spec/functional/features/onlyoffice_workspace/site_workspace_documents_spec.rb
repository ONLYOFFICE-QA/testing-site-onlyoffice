# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site For business Workspace documents' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @workspace = site_home_page.click_link_on_toolbar(:features_workspace)
    @documents = @workspace.click_on_section_link(:documents)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it "[Site][Workspace][Documents]'Check select section documents" do
    expect(@documents.check_select?('docmanage')).to be true
  end
end
