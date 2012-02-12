require_relative '../test_helpers'

class ApiHomePageTest < Test::Unit::TestCase
  include TestHelpers
  
  def setup
    @valid_api_key = 'valid'

    $redis.flushdb
    $redis.sadd 'api_keys', @valid_api_key
  end

  def test_displays_zero_initially
    get '/'
    assert_match /<h1>0<\/h1>/, last_response.body, 'Should display zero'
  end

  def test_displays_one_after_post
    header('X-Api-Key', @valid_api_key)
    post '/api'
    get '/'
    assert_match /<h1>1<\/h1>/, last_response.body, 'Should display one'
  end
end
