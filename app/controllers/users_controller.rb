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

  def update
    @user = User.where({ :id => params.fetch(:id) }).at(0)
    if @user.update(user_params)
      redirect_to(user_path(@user), notice: "Updated user profile")
    else
      render :edit, alert: "Something went wrong when saving"
    end
  end

  # TODO
  def destroy; end

  private

  def user_params
    params.expect(user: [ :username, :bio, :display_name, :location ])
  end
end
