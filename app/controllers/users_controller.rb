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
  # check user's input is not blank
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      erb :'users/create_user', locals: {message: "Fields cannot be blank"}

  # create new user object
  	elsif !user_exists?(params[:email], params[:username])
      @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.save #saves the new user to the database
      session[:user_id] = @user.id #saves the user id in the session variable (hash)
      redirect to '/destinations'
  # email already in use
    else
      erb :'users/create_user', locals: {message: "User already exists.  Please create new user."}
  
    end
  end
  
  #validate uniqueness of the Username 

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

  def user_exists?(email, username)
    @user = User.find_by(email: email, username: username)
    if @user.present?
      true
    else
      false
    end
  end


  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
  
end
