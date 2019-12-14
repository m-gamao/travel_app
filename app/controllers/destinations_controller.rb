class DestinationsController < ApplicationController

    get '/destinations' do 
        if logged_in?
            destinations = destination.all
            @user = User.find(session[:user_id])
            @user_destinations = destinations.select do |destination|
                destination.user_id == @user.id 
            end
            erb :'destinations/index'
        else
            redirect to '/login'
        end 
    end
    #checks if user is logged in. gets user's destination index if it's the same user as current session. 

    get '/destinations/new' do 
        if logged_in?
            erb :'destinations/new'
        else 
            redirect to '/login'
        end 
    end 
    #checks if logged in. if logged in it gets the page new page/form. 

    post '/destinations' do
        if logged_in?
            if params[:name == "" || params[:location] == "" || params[:description] == "" 
                redirect to 'destinations/new'
            else
                @destination = current_user.destinations.build(name: params[:name], location: params[:location], description: params[:description]
                if @destination.save
                    redirect to "destinations/#{@destination.id}"
                else 
                    redirect to 'destinations/new'
                end 
            end 
        else 
            redirect to '/login'
        end 
    end 
    #if user is logged in and leaves fields empty redirects them to new page again. if user fills out the form correctly, it will save and redirect the show page. 



  get '/destinations/:id' do
    if logged_in?
      @destination = Destination.find_by_id(params[:id])
      erb :'destinations/show_destination'
    else
      redirect to '/login'
    end
  end

  get '/destinations/:id/edit' do
    if logged_in?
      @destination = Destination.find_by_id(params[:id])
      if @destination && @destination.user == current_user
        erb :'destinations/edit_destination'
      else
        redirect to '/destinations'
      end
    else
      redirect to '/login'
    end
  end
  #gets the edit page


patch '/destinations/:id' do 
  if logged_in?
      if params[:name] == "" || params[:location] == "" || params[:description] == ""
          redirect to "/destinations/#{params[:id]}/edit"
      else
          @destination = Destination.find(params[:id])
          if @destination && @destination.user == current_user
              if @destination.update(name: params[:name], location: params[:location], description: params[:description])
                  redirect to "/destinations/#{@destination.id}"
              else 
                  redirect to "/destinations/#{@destination.id}/edit"
              end 
          else 
              redirect to '/destinations'
          end 
      end
  else 
      redirect to '/login'
  end 
end  
#updates and saves the edit page if filled out correctly 

delete '/destinations/:id/delete' do 
  if logged_in?
      @destination = Destination.find(params[:id])
      if @destination && @destination.user == current_user
          @destination.delete
      end 
      redirect to '/destinations'
  else
      redirect to '/login'
  end 
end 
end
#deletes the destination  if it belongs to the current user. If it's not current user's destination  it redirects them to their index page. 