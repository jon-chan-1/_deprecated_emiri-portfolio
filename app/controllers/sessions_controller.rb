class SessionsController < ApplicationController
  PASSWORD = "chocolateasdfhjkaskhjfkjsaf"

  def new
  end

  def create
    if params[:session][:password] == PASSWORD
      enter(request.remote_ip)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
  end
end
