require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/content_for'
require 'tilt/erubis'

# Absolute path to this directory
ROOT = File.expand_path("..", __FILE__)

helpers do
  # Displays list of files from the data directory
  def display_files
    list_items = Dir.glob(ROOT + "/data/*").map do |file_path|
      basename = File.basename(file_path)
      "<li><a href='/#{basename}'>#{basename}</a></li>"
    end.join

    "<ul>#{list_items}</ul>"
  end
end

get "/" do
  "getting started"
  erb :index
end

get "/:filename" do |filename|
  @content = File.read(ROOT + "/data/" + filename)
  erb :file
end