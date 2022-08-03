# frozen_string_literal: true

module TestingApiOnlyfficeCom
  # Config of running tests
  class Config
    # @return [String] Url of production site
    PRODUCTION_URL = 'https://www.onlyoffice.com'
    # @return [String] Url of staging site
    STAGING_URL = 'https://teamlab.info'
    # @return [String] server url
    attr_reader :server
    # @return [Symbol] browser
    attr_reader :browser
    # @return [String] language
    attr_reader :language
    # @return [String] region
    attr_reader :region

    def initialize(params = {})
      @server = params.fetch(:server, default_server)
      @region = params.fetch(:region, default_region) if @server.include?('com')
      @language = params.fetch(:language, default_language)
      @browser = params.fetch(:browser, :chrome)
    end

    # Convert current config to production site
    def to_production
      @server = PRODUCTION_URL
      self
    end

    private

    # @return [String] server on which test are performed
    def default_server
      return PRODUCTION_URL if ENV.fetch('SPEC_REGION', 'unknown').include?('com')

      STAGING_URL
    end

    def default_language
      ENV.fetch('SPEC_LANGUAGE', 'en-US')
    end

    def default_region
      # TODO: Handle region after fix
      # https://github.com/ONLYOFFICE/testing-wrata/issues/990
      'us'
    end
  end
end
