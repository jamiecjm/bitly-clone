get '/' do
  erb :"static/index"
end

post '/urls' do
	puts "+++"
	puts params
    url = Url.create(original_url: params[:long_url])
  if url.save
  	redirect "/"
  end
end

# i.e. /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
  shorturl = params[:short_url]
  url = Url.find_by(short_url: shorturl)
  redirect url.original_url
end
