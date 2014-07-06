class AppController < Sinatra::Base

  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do

    if params[:user_query]
      @query = params[:user_query]
    end

    erb :'index'
  end

  post '/search' do
    @query = params[:user_query]
    @result = RedditScraper.new(@query).scrape

    erb :'search_result'
  end

end