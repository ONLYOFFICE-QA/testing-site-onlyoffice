module TestingSiteOnlyffice
  class SiteConnectorReleaseData
    attr_accessor :version, :date

    def initialize(params = {})
      @version = params[:version]
      @date = params[:date]
    end

    def ==(other)
      version == other.version &&
        date == other.date
    end
  end
end
