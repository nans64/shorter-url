class StaticPagesController < ApplicationController

    def index
      @urls = ShortenedUrl.all
      @url = ShortenedUrl.new
    end

end
