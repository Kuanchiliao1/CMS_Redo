require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/content_for'
require 'tilt/erubis'
require 'redcarpet'

# Absolute path to this directory
ROOT = File.expand_path("..", __FILE__)

configure do
  enable :sessions
  set :session_secret, 'A\xFD\xBC\xAasdfasdfasdfasdfasdfasdffweaefsadfsadfasdfasdfasd5\x1A\x8E\xD7\x17W\x00r5\x8CHv\xA7\xFB6\xB8N\x9Fb\x93\xA4\x9Aw\x8E\bq\xBA\xFC\xEF\xA3\x9E\xE2\xED\xB1\b\xBC\xE3\xDA\xEA\xDB\xF2\xAC0\xDAh\xCE\x88/(\x16\xC9\xDD'
end

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
  erb :index
end

get "/:filename" do |filename|
  
  if File.exist?(ROOT + "/data/" + filename)
    @content = File.read(ROOT + "/data/" + filename)
    
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    # Renders whatever MD is in argument into HTML
    @content = markdown.render(@content) if File.extname(filename) == ".md"
    erb :file
  else
    session[:failure] = "The file does not exist"
    redirect "/"
  end
end
