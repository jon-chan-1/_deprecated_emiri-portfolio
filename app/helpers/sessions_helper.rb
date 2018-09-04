module SessionsHelper

  def enter(ip)
    session[:user_id] = ip
  end

  def allowed?(ip)
    if session[:user_id] != ip
      redirect_to enter_path
    end
  end
end
