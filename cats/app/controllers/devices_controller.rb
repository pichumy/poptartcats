class DevicesController < ApplicationController
  def show
    p params
    @devices = Session.where(user_id: params[:user_id])
    render :show
  end
end
