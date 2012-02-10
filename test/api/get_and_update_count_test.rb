require_relative '../test_helpers'

require 'timecop'

class ApiGetAndUpdateCountTest < Test::Unit::TestCase
  include TestHelpers
  
  def setup
    @valid_api_key = 'valid'
    @now = Time.new(2012, 2, 9, 13, 20)

    $redis.flushdb
    $redis.sadd 'api_keys', @valid_api_key
    header('X-Api-Key', @valid_api_key)
    Timecop.freeze(@now)
  end

  def teardown
    Timecop.return
  end

  def test_perform_get
    get '/api'
    assert_equal 200, last_response.status, 'Should perform GET'
  end

  def test_count_starts_at_zero
    get '/api'
    assert_equal '0', last_response.body, 'Should return zero'
  end

  def test_post_returns_updated_count
    post '/api'
    assert_equal '1', last_response.body, 'Should get updated count on POST'
  end

  def test_count_increases_after_post
    post '/api'
    get '/api'
    assert_equal '1', last_response.body, 'Should increase count after POST'
  end
end
