# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # Config of running tests
  class Config
    # @return [String] server url
    attr_reader :server
    # @return [Symbol] browser
    attr_reader :browser
    # @return [String] language, region
    attr_reader :language, :region

    def initialize(params = {})
      @server = params.fetch(:server, default_server)
      @region = params.fetch(:region, default_region) if @server.include?('com')
      @language = params.fetch(:language, default_language)
      @browser = params.fetch(:browser, :chrome)
    end

    private

    # @return [String] server on which test are performed
    def default_server
      return 'https://www.onlyoffice.com' if ENV['SPEC_REGION']&.include?('com')

      'https://teamlab.info'
    end

    def default_language
      return 'en-US' if ENV['SPEC_LANGUAGE'].blank?

      ENV['SPEC_LANGUAGE']
    end

    def default_region
      return 'us' if ENV['SPEC_REGION'].blank?

      ENV['SPEC_REGION'].split[-1]
    end
  end
end
