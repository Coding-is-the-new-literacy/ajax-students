get '/posts' do
  if session[:student_id]
    @posts = Post.all
    erb :"/posts/all"
  else
    redirect '/login'
  end
end

get '/posts/new' do
  @post = Post.new
  erb :"/posts/new"
end

# post request for creating
# post '/posts' do
#   @post = Post.new(title: params[:title], content: params[:content], student: current_student)
#   if @post.save
#     redirect '/posts'
#   else
#     erb :"/posts/new"
#   end
# end

post '/posts' do
  @post = Post.new(title: params[:title], content: params[:content], student: current_student)
  if request.xhr?
    content_type :json
    response_hash = {}
    if @post.save
      response_hash[:title]=@post.title
      response_hash[:content]=@post.content
      response_hash.to_json
    else
      422
    end
  else
    if @post.save
      redirect '/posts'
    else
      erb :"/posts/new"
    end
  end
end

get '/posts/:id' do
  @post = Post.find(params[:id])
  if @post
    erb :"/posts/show"
  else
    redirect '/posts'
  end
end

get '/posts/:id/edit' do
  @post = Post.find(params[:id])
  if @post
    erb :"/posts/edit"
  else
    redirect '/posts'
  end
end

put '/posts/:id' do
  @post = Post.find(params[:id])
  if @post.update(content: params[:content], title: params[:title])
    redirect "/posts/#{@post.id}"
  else
    erb :"posts/edit"
  end
end

delete '/posts/:id' do
  @post = Post.find(params[:id])
  @post.delete
  redirect '/posts'
end