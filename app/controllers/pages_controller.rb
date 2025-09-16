class PagesController < ApplicationController
  allow_unauthenticated_access(only: :landing)

  def landing
    if authenticated?
      redirect_to :chirps
    else
      render :landing
    end
  end
end
