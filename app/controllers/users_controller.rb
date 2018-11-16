class UsersController < ApplicationController
  before_action :set_messenger
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /messengers/:messenger_id/users
  def index
    json_response(@messenger.users)
  end

  # GET /messengers/:messenger_id/users/:id
  def show
    json_response(@user)
  end

  # POST /messengers/:messenger_id/users
  def create
    @messenger.users.create!(user_params)
    json_response(@messenger, :created)
  end

  # PUT /messengers/:messenger_id/users/:id
  def update
    @user.update(user_params)
    head :no_content
  end

  # DELETE /messengers/:messenger_id/users/:id
  def destroy
    @user.destroy
    head :no_content
  end

  private

  def user_params
    params.permit(:name, :done)
  end

  def set_messenger
    @messenger = Messenger.find(params[:messenger_id])
  end

  def set_user
    @user = @messenger.users.find_by!(id: params[:id]) if @messenger
  end
end
