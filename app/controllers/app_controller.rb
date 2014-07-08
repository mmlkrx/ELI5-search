class AppController < Sinatra::Base

  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do

    if params[:user_query]
      @query = params[:user_query]
    end

    erb :'index'
  end

  post '/search' do
    scraper = RedditScraper.new(params[:user_query])
    @result = scraper.scrape
    @question = scraper.normalize_user_query

    erb :'search_result'
  end

end