module TestingSiteOnlyoffice
  class SiteConnectorReleaseData
    attr_accessor :version, :date

    def initialize(params = {})
      @version = params[:version]
      @date = fetch_release_date(params[:date])
    end

    def fetch_release_date(date)
      return date if date.instance_of?(Date)

      Date.strptime(date, '%m/%d/%Y') if date.is_a? String
    end

    def ==(other)
      version == other.version &&
        date == other.date
    end
  end
end
