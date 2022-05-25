# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Branch version' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Branch version' do
    page_branch_version = TestingSiteOnlyoffice::SiteHelper.new.branch_name
    expect(page_branch_version.include?('/release/' || '/hotfix/')).to be(true)
  end
end
