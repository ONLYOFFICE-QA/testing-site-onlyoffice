# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
branch_version = TestingSiteOnlyoffice::SiteHelper.new

describe 'Branch version' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Branch version' do
    branch_version.following_new_link('revision')
    page_branch_version = branch_version.text_body_page
    expect(page_branch_version.include?('/release/' || '/hotfix/')).to be(true)
  end
end
