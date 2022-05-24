# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Enterprise Edition' do
  before do
    site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @enterprise_edition = site_home_page.click_link_on_toolbar(:products_workspace_enterprise_edition)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it '[Workspace edition] Go to enterprise edition' do
    expect(@enterprise_edition).to be_a TestingSiteOnlyoffice::SiteEnterpriseEdition
  end
end
