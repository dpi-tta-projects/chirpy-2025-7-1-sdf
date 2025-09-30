class UsersController < ApplicationController
  # user GET    /users/:id(.:format)  users#show
  def show
    @user = User.where({ :id => params.fetch(:id) }).at(0)
    render :show
  end

  # TODO
  def new; end
  def create; end

  def edit
    # params = {"id" => "10"}
    @user = User.where({ :id => params.fetch(:id) }).at(0)

    if Current.user != @user
      redirect_to("/", alert: "You aren't supposed to edit other people's accounts")
    else
      render :edit
    end
  end

  def update; end

  # TODO
  def destroy; end
end
