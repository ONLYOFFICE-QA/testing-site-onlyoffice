# frozen_string_literal: true

module TestingSiteOnlyoffice
  # Module for working with testrail test management data
  module TestManagerTestrail
    # @param params [Hash] testrail params
    # @return [nil]
    def init_testrail(params)
      return unless Testrail2.new.available?

      @testrail = TestrailHelper.new(params[:product_name], params[:suite_name], params[:plan_name_testrail]) do |testrail_conf|
        testrail_conf.add_all_suites = false
        testrail_conf.search_plan_by_substring = false
      end
    end
  end
end
