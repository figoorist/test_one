class MessengersController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # GET /todos
  def index
    @messengers = Messenger.all
    json_response(@messengers)
  end

  # POST /todos
  def create
    @messenger = Messenger.create!(messenger_params)
    json_response(@messenger, :created)
  end

  # GET /todos/:id
  def show
    json_response(@messenger)
  end

  # PUT /todos/:id
  def update
    @messenger.update(messenger_params)
    head :no_content
  end

  # DELETE /todos/:id
  def destroy
    @messenger.destroy
    head :no_content
  end

  private

  def messenger_params
    # whitelist params
    params.permit(:name)
  end

  def set_todo
    @messenger = Messenger.find(params[:id])
  end
end
