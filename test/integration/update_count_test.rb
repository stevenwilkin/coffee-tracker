require_relative '../test_helpers'

require 'timecop'

class IntegrationUpdateCountTest < Test::Unit::TestCase
  include TestHelpers
  
  def setup
    @valid_api_key = 'valid'
    @now = Time.new(2012, 2, 9, 13, 20)

    $redis.flushdb
    $redis.sadd 'api_keys', @valid_api_key
    header('X-Api-Key', @valid_api_key)
    Timecop.freeze(@now)

    post '/api'
  end

  def teardown
    Timecop.return
  end

  def test_sets_key
    assert $redis.exists('coffee'), 'Should set key in Redis'
  end

  def test_sets_key_as_hash
    assert_equal 'hash', $redis.type('coffee'), 'Should set key to a hash value'
  end

  def test_sets_field_within_hash
    assert $redis.hexists('coffee', '20120209'), 'Should set field in hash'
  end

  def test_sets_field_to_correct_value
    assert_equal '1', $redis.hget('coffee', '20120209'), 'Should set field to correct value'
  end

  def test_increments_value_on_repeated_post
    post '/api'
    assert_equal '2', $redis.hget('coffee', '20120209'), 'Should increase field'
  end
end
