# frozen_string_literal: true

require 'spec_helper'

test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'About blogs' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

    it '[About] Go to blog}' do
      about_blogs_page = @site_home_page.click_link_on_toolbar(:about_blog)
      expect(about_blogs_page).to be_a TestingSiteOnlyoffice::SiteAboutBlog
    end
end
