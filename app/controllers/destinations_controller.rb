class DestinationsController < ApplicationController

    get '/destinations' do 
        if logged_in?
            @destinations = Destination.all
            @user = User.find(session[:user_id])
            erb :'destinations/index'
        else
            redirect to '/login'
        end 
    end
    #checks if user is logged in. gets user's destination index if it's the same user as current session. 

    #New
    #checks if logged in. if logged in it gets the page new page/form. 
    get '/destinations/new' do 
        if logged_in?
            erb :'destinations/new'
        else 
            redirect to '/login'
        end 
    end 

#Create
#if user is logged in and leaves fields empty redirects them to new page again. 
#if user fills out the form correctly, it will save and redirect the show page. 
    post '/destinations' do
        if logged_in?
            if params[:name] == "" || params[:location] == "" || params[:description] == "" 
                redirect to 'destinations/new'
            else
                @destination = current_user.destinations.build(name: params[:name], location: params[:location], description: params[:description])
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


#Show
  get '/destinations/:id' do
    if logged_in?
      @destination = Destination.find(params[:id])
      erb :'destinations/show'
    else
      redirect to '/login'
    end
  end

  #Edit
  #gets the edit page for the selected destination
  get '/destinations/:id/edit' do 
    if logged_in?
        @destination = Destination.find(params[:id])
        if @destination && @destination.user == current_user
            erb :'destinations/edit'
        else
            redirect to '/destinations'
        end 
    else
        redirect to '/login'
    end 
end 


#updates and saves the edit page if filled out correctly 
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

#Delete
#deletes the destination  if it belongs to the current user. 
#If it's not current user's destination, then it redirects them to their index page. 
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


