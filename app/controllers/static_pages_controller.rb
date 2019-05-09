class StaticPagesController < ApplicationController
    before_action :set_url, only: [:edit, :update, :destroy]

    def index
      @urls = ShortenedUrl.all
      @url = ShortenedUrl.new
    end

    # GET /videos/new
    def new
    end


end
