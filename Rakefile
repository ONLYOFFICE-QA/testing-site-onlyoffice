# frozen_string_literal: true

desc 'Task to upgrade secret config'
task :update_secret_config do
  sh('gpg --batch --yes -c lib/testing_site_onlyoffice/data/private_data/data.yml')
end
