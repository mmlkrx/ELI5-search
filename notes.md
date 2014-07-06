general breakdown

1. Search reddit/ELI5
2. choose best match
3. choose best answer
4. display best three answers

detailed breakdown after user hits "search"

1. get user input
2. search http://www.reddit.com/r/explainlikeimfive/search?q=  user.input  &restrict_sr=on&sort=relevance&t=all
3. open first search result with title explained
4. get the first answer with the higest upvotes
5. display that on our awesome web app

Filestructure

ELI5-search/
├── Gemfile
├── Gemfile.lock
├── README.md
├── Rakefile
├── app
│ ├── controllers
│ │ └── app_controller.rb
│ └── views
│   └── layout.erb
│   └── index.erb
├── config
│ └── environment.rb
├── config.ru
├── public
│ └── stylesheets
└── spec
├── controllers
├── features
└── spec_helper.rb

basic controller breakdown

the app controller will respond to two routes

  get '/'

and

  post '/'

the post route wont have any data the first time a user opens the website 
and thus will not display any information or search results