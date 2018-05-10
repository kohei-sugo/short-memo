class ToppagesController < ApplicationController
  def index
    if logged_in?
      redirect_to lists_path
    end
  end
end
