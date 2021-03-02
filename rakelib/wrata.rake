require 'wrata_api'

site_wrata_user = 'Site'

namespace(:wrata) do
  desc 'Check that correct user trying to run tests'
  task :ensure_user do
    api = WrataApi::WrataApi.new
    current_user = api.profile['login']
    next if current_user == site_wrata_user

    raise("You're trying to run wrata tests with #{current_user} instead of #{site_wrata_user}")
  end

  desc 'Turn on servers on Wrata'
  task :wrata_turn_on_servers, [:count] do |_, args|
    api = WrataApi::WrataApi.new
    free_pcs = api.free_servers(args[:count])
    free_pcs.power_on('1gb')
    free_pcs.book
    sleep(60) # timeout to correctly turn on of all services
  end

  desc 'Add tests to queue'
  task :add_tests_to_queue, [:location, :path] do |_, args|
    location = args[:location] || 'default'
    api = WrataApi::WrataApi.new
    all_files = api.file_list('ONLYOFFICE-QA/testing-site-onlyoffice')
    test_files = all_files.select { |spec| spec.start_with?(args[:path]) }
    test_files.each do |test|
      api.add_to_queue("~/RubymineProjects/testing-site-onlyoffice/#{test}",
                       location: location,
                       branch: 'master')
    end
  end

  desc 'Run test after site update'
  task :run_site_tests, [:location] => :ensure_user do |_, args|
    location = args[:location] || 'default'
    Rake::Task['wrata:wrata_turn_on_servers'].execute(count: 1)
    Rake::Task['wrata:add_tests_to_queue'].execute(location: location, path: 'spec/functional')
    puts('One test node is setup. Please check that test are run fine on it')
    sleep(3 * 60)
    Rake::Task['wrata:wrata_turn_on_servers'].execute(count: 1)
  end
end
