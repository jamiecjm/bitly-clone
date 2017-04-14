enable :sessions


get '/' do
  erb :"static/index"
end

post '/urls' do
  @url = Url.new(original_url: params[:long_url])
  if @url.save
  	# redirect "/"
    # erb: "static/table", layout:false
    return @url.to_json
  else
  	# flash[:warning] = "#{url.errors.messages.values.first.first}"
  	# redirect "/"
    status 400
    return @url.errors.messages.values.first.first
  end
end

# i.e. /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
  shorturl = params[:short_url]
  url = Url.find_by(short_url: shorturl)
  url.update(click_count: url.click_count += 1)
  redirect url.original_url
end

