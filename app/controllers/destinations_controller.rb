class DestinationsController < ApplicationController
  get '/destinations' do
    if logged_in?
      @destinations = destination.all
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
      @destination = destination.find_by_id(params[:id])
      erb :'destinations/show_destination'
    else
      redirect to '/login'
    end
  end

  get '/destinations/:id/edit' do
    if logged_in?
      @destination = destination.find_by_id(params[:id])
      if @destination && @destination.user == current_user
        erb :'destinations/edit_destination'
      else
        redirect to '/destinations'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          if @tweet.update(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"
          else
            redirect to "/tweets/#{@tweet.id}/edit"
          end
        else
          redirect to '/tweets'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end
end