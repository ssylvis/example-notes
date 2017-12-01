require 'securerandom'

class DevicesController < ApplicationController
  def create
    @device = Device.new(device_uid: SecureRandom.uuid)

    if @device.save
      redirect_to @device
    else
      render 'new'
    end
  end

  def destroy
    @device = Device.find(params[:id])
    @device.destroy

    redirect_to devices_path
  end

  def edit
    @device = Device.find(params[:id])
  end

  def index
    @devices = Device.all
  end

  def new
    @device = Device.new
  end

  def show
    @device = Device.find(params[:id])
  end

  def update
    @device = Device.find(params[:id])

    if @device.update
      redirect_to @device
    else
      render 'edit'
    end
  end

  private

end
