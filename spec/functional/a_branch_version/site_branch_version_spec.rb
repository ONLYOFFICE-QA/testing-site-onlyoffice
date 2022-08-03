# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
site_helper = TestingSiteOnlyoffice::SiteHelper.new

describe 'Branch version' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  it 'Branch version' do
    site_helper.open_sublink('revision')
    expect(site_helper.page_body).to match('/release/|/hotfix/')
  end
end
