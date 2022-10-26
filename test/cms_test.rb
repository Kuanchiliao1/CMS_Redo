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

  def test_file_not_found
    # Attempting to access non existant file
    get "/noneexistantfile"

    # Verify that a redirection occurred
    assert_equal(302, last_response.status)
    
    # Send a request to the redirection
    get last_response["Location"]
    
    assert_includes(last_response.body, "The file does not exist")
  end
end