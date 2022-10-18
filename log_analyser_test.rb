require_relative  "test_helper"

describe LogAnalyser do
  before do
    @log_analyser = LogAnalyser.new("test.log")
  end

  describe "public interface" do
    it "responds to defined  messages" do
      _(@log_analyser).must_respond_to :number_of_requests
      _(@log_analyser).must_respond_to :total_time_covered
      _(@log_analyser).must_respond_to :requests_per_minute
      _(@log_analyser).must_respond_to :total_data
      _(@log_analyser).must_respond_to :average_data_sent_per_request
      _(@log_analyser).must_respond_to :largest_data_sent_per_request
    end
  end

  describe "number of requests" do
    it "returns the total amount of lines in a log file" do
      _(@log_analyser.number_of_requests).must_equal 5
    end
  end

  describe "total time covered" do
    it "returns the seconds between first and last timestamps" do
      _(@log_analyser.total_time_covered).must_equal 124
    end
  end

  describe "requests per minute" do
    it "returns the number of requests performed in a minute" do
      _(@log_analyser.requests_per_minute).must_equal 3
    end
  end

  describe "total data" do
    it "returns the sum of bytes in megabytes to 2 significant figures" do
      _(@log_analyser.total_data).must_equal 0.01
    end
  end

  describe "average data sent per request" do
    it "returns the mean average of bytes in kilobytes to significant figures" do
      _(@log_analyser.average_data_sent_per_request).must_equal 1.49
    end
  end

  describe "largest data sent per request" do
    it "returns the largest kilobyte amount of data sent in 1 request to 2 significant figures" do
      _(@log_analyser.largest_data_sent_per_request).must_equal 7.46
    end
  end
end
