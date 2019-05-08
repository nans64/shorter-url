class StaticPagesController < ApplicationController
  def index
    @urls = Shortener::ShortenedUrl.all

    unless params[:url].nil?

      @url = ShortenedUrl.sanitize(params[:url])

      if Shortener::ShortenedUrl.where(url: @url, owner: current_user).empty?

        Shortener::ShortenedUrl.generate(@url, owner: current_user, fresh: true)
        flash[:success] = "L'URL a été transformé avec succès - 1."

      elsif !Shortener::ShortenedUrl.where(url: @url).empty?

        @urls = Shortener::ShortenedUrl.where(url: @url)
        flash[:success] = "L'URL a déjà été ajouté, vous pourrez la trouver ci-dessous."

      else

        Shortener::ShortenedUrl.generate(@url, owner: current_user)
        flash[:success] = "L'URL a été transformé avec succès - 3."
        redirect_to "/"

      end

    end
  end
end
