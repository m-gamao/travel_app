class DestinationsController < ApplicationController
  get '/destinations' do
    if logged_in?
      @destinations = Destination.all
      erb :'destinations/destinations'
    else
      redirect to '/login'
    end 
  end

  get '/destinations/new' do
    if logged_in?
      erb :'destinations/create_destination'
    else
      redirect to '/login'
    end
  end

  post '/destinations' do
    if logged_in?
      if params[:content] == ""
        redirect to "/destinations/new"
      else
        @destination = current_user.destinations.build(content: params[:content])
        if @destination.save
          redirect to "/destinations/#{@destination.id}"
        else
          redirect to "/destinations/new"
        end
      end
    else
      redirect to '/login'
    end
  end

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

  patch '/destinations/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/destinations/#{params[:id]}/edit"
      else
        @destination = Destination.find_by_id(params[:id])
        if @destination && @destination.user == current_user
          if @destination.update(content: params[:content])
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

  delete '/destinations/:id/delete' do
    if logged_in?
      @destination = Destination.find_by_id(params[:id])
      if @destination && @destination.user == current_user
        @destination.delete
      end
      redirect to '/destinations'
    else
      redirect to '/login'
    end
  end
end