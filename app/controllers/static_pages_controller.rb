class StaticPagesController < ApplicationController
  def index

    if params[:search] ? Shortener::ShortenedUrl.generate(params[:search], owner: current_user) : nil
    end

  end

end
