class UsersController < ApplicationController
  allow_unauthenticated_access(only: [ :new, :create ])

  def new
    # TODO: redirect to users#show if signed_in

    @user = User.new
    render :new
  end

  def create
    @user = User.new(registration_params)
    @user.display_name = registration_params.fetch(:username)

    if @user.save
      start_new_session_for(@user)
      redirect_to user_path(@user), notice: "Successfully created a new account"
    else
      render :new, alert: "Unable to create a user"
    end
  end

  # user GET    /users/:id(.:format)  users#show
  def show
    @user = User.where({ :id => params.fetch(:id) }).at(0)
    @chirps = @user.chirps.originals
    render :show
  end

  def replies
    @user = User.find_by(id: params[:id])
    @chirps = @user.chirps.replies.includes(parent_chirp: :user)
    render :show
  end

  def likes
    @user = User.find_by(id: params[:id])

    # raise Pundit::NotAuthorizedError unless UserPolicy.new(Current.user, @user).likes?
    authorize @user

    @chirps = @user.liked_chirps.includes([ :user, :parent_chirp ])
    render :show
  end

  def edit
    # params = {"id" => "10"}
    @user = User.where({ :id => params.fetch(:id) }).at(0)

    if Current.user != @user
      redirect_to("/", alert: "You aren't supposed to edit other people's accounts")
    else
      render :edit
    end
  end

  def feed_preference
    @user = User.find_by(id: params[:id])
    if @user.update(feed_preference_params)
      redirect_to(chirps_path, notice: "Updated feed preference")
    else
      render :edit, alert: "Something went wrong when saving"
    end
  end

  def update
    @user = User.where({ :id => params.fetch(:id) }).at(0)
    if @user.update(profile_params)
      redirect_to(user_path(@user), notice: "Updated user profile")
    else
      render :edit, alert: "Something went wrong when saving"
    end
  end

  # TODO
  def destroy; end

  def following
    @user = User.find_by(id: params[:id])
  end

  def followers
    @user = User.find_by(id: params[:id])
  end

  private

  def registration_params
    params.expect(user: [ :email_address, :username, :password, :password_confirmation ])
  end

  def profile_params
    params.expect(user: [ :username, :bio, :display_name, :location ])
  end

  def feed_preference_params
    params.expect(user: [ :feed_preference ])
  end
end
