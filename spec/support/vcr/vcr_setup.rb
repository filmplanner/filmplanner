require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr'
  c.allow_http_connections_when_no_cassette = true
  c.ignore_localhost = true

  c.hook_into :webmock
end
