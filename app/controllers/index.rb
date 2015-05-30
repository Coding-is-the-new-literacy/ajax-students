
# in the controller

get '/' do
  if session[:student_id]
    redirect '/posts'
  else
    redirect '/login'
  end
end

get '/login' do
  if session[:student_id]
    redirect '/home'
  else
    erb :"/students/login"
  end
end

get '/students/new' do
  erb :"students/new"
end

post '/students' do
  @student = Student.new(email: params[:email], password: params[:password])
  if @student.save
    session[:student_id] = @student.id
    erb :"/students/home"
  else
    erb :"/students/new"
  end
end


post '/login' do
  @student = Student.authenticate(params[:email], params[:password])
  if @student
    session[:student_id] = @student.id
    redirect '/home'
  else
    erb :"/students/login"
  end
end

get '/logout' do
  session.clear
  redirect '/login'
end

get '/home' do
  if session[:student_id]
    erb :"/students/home"
  else
    redirect '/login'
  end
end


