class FollowsController < ApplicationController
  def create
    @follow = Follow.new(follow_params)
    @follow.follower = Current.user

    if @follow.save
      redirect_to user_path(@follow.following), notice: "Successfully followed @#{@follow.following.username}"
    else
      redirect_to user_path(@follow.following), alert: "Unable to follow user"
    end
  end

  def destroy
    @follow = Follow.find_by(id: params.fetch(:id))

    if @follow.destroy
      redirect_to user_path(@follow.following), notice: "Successfully un-followed @#{@follow.following.username}"
    else
      redirect_to user_path(@follow.following), alert: "Unable to un-follow user"
    end
  end

  # TODO
  # def followers
  # end

  # TODO
  # def following
  # end

  def follow_params
    params.expect(follow: [ :following_id ])
  end
end
