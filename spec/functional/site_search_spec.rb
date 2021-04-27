require 'spec_helper'
test_manager = TestingSiteOnlyoffice::TestManager.new(suite_name: File.basename(__FILE__))

describe 'Site search' do
  before do
    @site_home_page, @test = TestingSiteOnlyoffice::SiteHelper.new.open_page_teamlab_office(config)
    @site_home_page.open_search_field
  end

  describe 'non-existing word' do
    before { @result_page = @site_home_page.search('Fakeword') }

    it 'Non-existing word return No results matching your query page and zero found results' do
      expect(@result_page.no_result_found_element).to be_present
      expect(@result_page.search_result_count).to eq(0)
    end

    it 'Check `Go to main page` button work for No results matching your query page' do
      main_page = @result_page.go_to_main_page
      expect(main_page).to be_a TestingSiteOnlyoffice::SiteHomePage
    end
  end

  it 'Search for existing method result several results' do
    search_string = 'calendar'
    result_page = @site_home_page.search(search_string)
    expect(result_page.search_result_count).to be > 0
    expect(result_page.first_snippet_entry_text).to be_include(search_string)
  end

  it 'xss injection return No results matching your query page' do
    pending('xss injection return old site error page')
    result_page = @site_home_page.search('"><script>alert(1)</script>')
    expect(result_page.no_result_found_element).to be_present
  end

  after do |example|
    test_manager.add_result(example)
    @test.webdriver.quit
  end
end
