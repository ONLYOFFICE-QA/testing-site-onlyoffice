require_relative 'palladium_wraper'
require_relative 'test_manager_testrail'
require 'onlyoffice_tcm_helper'
require 'mechanize'

# it is helper for adding result to test case management system, like palladium and testrail
# for using, create TestManager object in your mail describe
# Example: test_manager = TestManager.new(suite_name: description)
# Then, add result in `after: each` block
# Example: test_manager.add_result(example)
module TestingSiteOnlyoffice
  class TestManager
    include PalladiumWrapper
    include TestManagerTestrail

    def initialize(params = {})
      params[:suite_name] ||= File.basename(__FILE__)
      params[:plan_name] ||= "Site Domain: #{PortalHelper.new.get_portal_name}, Version: #{TestingSiteOnlyoffice::SiteVersionHelper.full_site_version}"
      params[:plan_name_testrail] ||= "Site Domain: #{PortalHelper.new.get_portal_name}, Version: #{TestingSiteOnlyoffice::SiteVersionHelper.full_site_version}"
      params[:product_name] ||= 'Site onlyoffice.com Autotests'
      @tcm_helper = OnlyofficeTcmHelper::TcmHelper.new(params)
      @palladium = init_palladium(params)

      init_testrail(params)
    end

    # @param [RSpec::Core::Example] example - is a returned object in "after" block
    # @param [Hash] comment is a data for reuslt. It *must* contain :title and :value keys
    def add_result(example, comment = {})
      result = @tcm_helper.parse(example)
      formatting_describer(comment)
      @testrail&.add_result_to_test_case(example)

      return unless @palladium

      add_palladium_result(result)
    end

    # take describer in TcmHelper.result_message and reformat it
    def formatting_describer(comment)
      result_message = JSON.parse(@tcm_helper.result_message)
      describer = result_message['describer'][0]['value']
      new_describer = []
      new_describer << comment unless comment == {}
      new_describer << { title: 'Comment', value: describer.split('Page address')[0] }
      new_describer << { value: describer.split('Page address: ')[1],
                         title: 'Page address' }
      new_describer << { value: describer.split('Error screenshot: ')[1],
                         title: 'Error screenshot',
                         type: :image }
      result_message['describer'] = new_describer
      @tcm_helper.result_message = result_message.to_json
    end

    # get code for colorize message in console
    def get_result_color(status_name)
      { failed: 45, pending: 43, passed: 42, passed_2: 46, aborted: 41, blocked: 44 }[status_name]
    end

    private

    # Add result info to palladium
    # @param result [TcmHelper] info to add
    # @return [nil]
    def add_palladium_result(result)
      @palladium.set_result(status: result.status.to_s, description: result.result_message, name: result.case_name)
      OnlyofficeLoggerHelper.log("Set test case result to palladium: #{result.status}." \
                               "URL: #{@palladium.result_set_link}",
                                 get_result_color(result.status))
    rescue StandardError => e
      OnlyofficeLoggerHelper.log("Can't write result to palladium. Error: #{e}")
    end
  end
end
