class UsersController < ApplicationController
  #slug allows you to put the user's name without using the user id
  # get '/users/:slug' do
  #   @user = User.find_by_slug(params[:slug])
  #   erb :'users/show'
  # end

  get '/signup' do
    if !logged_in?
      erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
    else
      redirect to '/destinations'
    end
  end

  post '/signup' do
    # user's input cannot be blank
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      erb :'users/create_user', locals: {message: "Fields cannot be blank"}
    # create new user object
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save #sends info to the user model and hits validations, and saves the new user to the database
        session[:user_id] = @user.id #saves the user id in the session variable (hash)
        redirect to '/destinations'
      
      #email already in use
      else
        erb :'users/create_user', locals: {message: "User already exists. Please create new user."}
    end
  end
end
  
get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/destinations'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/destinations"
    else
      redirect to '/signup'
    end
  end


#added this element to the views/layout.rb under yield.
  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
  
end
