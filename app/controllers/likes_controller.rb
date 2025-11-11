class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @like.user = Current.user

    respond_to do |format|
      if @like.save
        format.html { redirect_to(chirp_path(@like.chirp), notice: "Succesfully liked chirp") }
        format.js
      else
        format.html { redirect_to(chirp_path(@like.chirp), alert: "Unable to like chirp") }
      end
    end
  end

  def destroy
    @like = Like.find_by(id: params.fetch("id"))

    respond_to do |format|
      if @like.destroy
        format.html { redirect_to(chirp_path(@like.chirp), notice: "Succesfully un-liked chirp") }
        format.js
      else
        format.html { redirect_to(chirp_path(@like.chirp), alert: "Unable to un-like chirp") }
      end
    end
  end

  private

  def like_params
    params.expect(like: [ :chirp_id ])
  end
end
