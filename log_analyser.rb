require 'date'
require 'time'

class LogAnalyser
  attr_reader :log

  def initialize(log)
    @log = log
    @lines = IO.readlines(@log)
  end

  def number_of_requests
    @lines.count
  end

  def total_time_covered
    first_timestamp = timestamp(@lines.first)
    last_timestamp = timestamp(@lines.last)

    time_covered = (last_timestamp - first_timestamp)
    seconds(time_covered)
  end

  def requests_per_minute
    end_time = time(timestamp(@lines.first)) + 60

    @lines.select{ |line|
      time(timestamp(line)) <= end_time
    }.count
  end

  def total_data
    (total_bytes(@lines).last / 1048576.0).round(2)
  end

  def average_data_sent_per_request
    ((total_bytes(@lines).last / @lines.count) / 1024.0).round(2)
  end

  def largest_data_sent_per_request
    (total_bytes(@lines).max / 1024.0).round(2)
  end

  private

  def timestamp(line)
    DateTime.parse(line.split(' ').first)
  end

  def time(timestamp)
    Time.parse(timestamp.to_s)
  end

  def seconds(time)
    (time * 24 * 60 * 60).to_i
  end

  def total_bytes(lines)
    bytes_array = []
    lines.map { |line|
      line_bytes = line.scan(/bytes=\w+/)
      bytes_array << line_bytes.to_s.scan(/\d/).join.to_i
      bytes_array.reduce(:+)
    }
  end
end

analysis = LogAnalyser.new("sample.log")

puts "Number of requests: #{analysis.number_of_requests}"
puts "Total time covered: #{analysis.total_time_covered} seconds"
puts "Requests per minute: #{analysis.requests_per_minute}"
puts "Total amount of data sent: #{analysis.total_data} MB"
puts "Average amount of data sent per request: #{analysis.average_data_sent_per_request} KB"
puts "Largest amount of data sent in a single request: #{analysis.largest_data_sent_per_request} KB"
