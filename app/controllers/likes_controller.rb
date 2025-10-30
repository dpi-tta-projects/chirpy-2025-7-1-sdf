class LikesController < ApplicationController
  def create
    like = Like.new(like_params)
    like.user = Current.user

    if like.save
      redirect_to(chirp_path(like.chirp), notice: "Succesfully liked chirp")
    else
      redirect_to(chirp_path(like.chirp), alert: "Unable to like chirp")
    end
  end

  def destroy
    like = Like.find_by(id: params.fetch("id"))

    if like.destroy
      redirect_to(chirp_path(like.chirp), notice: "Succesfully un-liked chirp")
    else
      redirect_to(chirp_path(like.chirp), alert: "Unable to un-like chirp")
    end
  end

  private

  def like_params
    params.expect(like: [ :chirp_id ])
  end
end
