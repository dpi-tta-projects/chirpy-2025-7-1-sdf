class ApplicationController < ActionController::Base
  include Authentication, Authorizeable
  skip_forgery_protection
end
