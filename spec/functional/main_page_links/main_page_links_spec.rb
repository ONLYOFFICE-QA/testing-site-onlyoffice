# frozen_string_literal: true

require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))
blocked_high_rated_by_critics = %w[capterra highperformer]
blocked_high_rated_by_users = %w[capterra getapp]

describe 'Help center footer links' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
  end

  after do |example|
    test_manager.add_result(example, @test)
    @test.webdriver.quit
  end

  TestingSiteOnlyoffice::MainPageLinksData.free_desktop_and_mobile_apps.each do |app|
    it "[Site][HomePage] `#{app}` link of `Free desktop and mobile apps` section works" do
      expect(@site_home_page).to be_desktop_and_mobile_apps_element_works(app)
    end
  end

  TestingSiteOnlyoffice::MainPageLinksData.built_for_everyone.each do |solution|
    it "[Site][HomePage] `#{solution}` link of `Built for everyone` section works" do
      expect(@site_home_page).to be_built_for_everyone_element_works(solution)
    end
  end

  TestingSiteOnlyoffice::MainPageLinksData.rated_by_critics.each do |app|
    it "[Site][HomePage] `#{app}` link of `Highly rated by critics` section works" do
      pending('Opening this link is blocked by third party service firewall') if blocked_high_rated_by_critics.include?(app)
      expect(@site_home_page).to be_rated_by_critics_element_works(app)
    end
  end

  TestingSiteOnlyoffice::MainPageLinksData.rated_by_users.each do |app|
    it "[Site][HomePage] `#{app}` link of `Highly rated by users` section works" do
      pending('Opening this link is blocked by third party service firewall') if blocked_high_rated_by_users.include?(app)
      expect(@site_home_page).to be_rated_by_users_element_works(app)
    end
  end

  it '[Site][HomePage] Block news link works' do
    expect(@site_home_page).to be_xpath_success_response(@site_home_page.blog_news_element.selector[:xpath])
  end

  it '[Site][HomePage] Webinars news link works' do
    expect(@site_home_page).to be_xpath_success_response(@site_home_page.webinar_news_element.selector[:xpath])
  end

  TestingSiteOnlyoffice::MainPageLinksData.get_onlyoffice_main_page.each do |title, xpath|
    it "[Site][HomePage] `#{title}` works" do
      expect(@site_home_page).to be_xpath_success_response(xpath)
    end
  end

  TestingSiteOnlyoffice::MainPageLinksData.customers_main_page.each do |title, xpath|
    it "[Site][HomePage] `#{title}` link of `Trusted by more than 7 000 000 users worldwide` works" do
      expect(@site_home_page).to be_xpath_success_response(xpath)
    end
  end
end
