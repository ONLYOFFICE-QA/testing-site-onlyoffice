# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # Config of running tests
  class Config
    # @return [String] server url
    attr_reader :server
    # @return [Symbol] browser
    attr_reader :browser

    def initialize(params = {})
      @server = params.fetch(:server, default_server)
      @browser = params.fetch(:browser, :chrome)
    end

    private

    # @return [String] server on which test are performed
    def default_server
      return 'https://onlyoffice.com' if ENV['SPEC_REGION']&.include?('com')

      'https://teamlab.info'
    end
  end
end
