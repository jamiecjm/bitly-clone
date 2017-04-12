get '/' do
  erb :"static/index"
end

get '/saved/:id' do
	id = params[:id]
	@url = Url.find(id)
	erb :"static/saved"
end

post '/urls' do
	puts "+++"
	puts params
    url = Url.create(original_url: params[:long_url])
  if url.save
  	redirect "saved/#{url.id}"
  end
end

# i.e. /q6bda
get '/:short_url' do
  # redirect to appropriate "long" URL
  url = Url.find_by(short_url: :short_url)
  long_url = url.original_url
  erb :long_url
end

# post '/create_user' do
# 	#params #<== a hash that you pass from you form to the controller action
# 	puts "++++++++++++++++++++++++++++++++++++++++++"
# 	puts params
# 	puts "++++++++++++++++++++++++++++++++++++++++++"
# 	user = User.create(name: params[:name], email: params[:email])
# 	if user.save
# 		redirect "user_profile/#{user.id}"
# 	else
# 		render 'static/signup'
# 	end
# end

# # lsof -i :9393
# #kill -9 PID 

# get '/user_profile/:id' do
# 	id = params[:id]
# 	@user = User.find(id)
# 	@title = "New Title"
# 	erb :'users/profile'
# end