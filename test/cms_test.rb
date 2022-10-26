# This is to tell
ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "minitest/reporters"
require "rack/test"
Minitest::Reporters.use!

require_relative '../cms'



class CMSTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get "/"

    assert_equal(200, last_response.status)
    binding.pry

    # Remember that the body is just a long string
    assert_includes(last_response.body, "about.txt")
    assert_includes(last_response.body, "changes.txt")
    assert_includes(last_response.body, "history.txt")
    
  end

  def test_about_file
    get "/about.txt"
    assert_equal(200, last_response.status)
    assert_equal("not about you...", last_response.body)
  end
end