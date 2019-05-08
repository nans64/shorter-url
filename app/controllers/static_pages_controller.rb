class StaticPagesController < ApplicationController
  def index
    @urls = Shortener::ShortenedUrl.all

    if ShortenedUrl.is_not_empty?(params[:url])

      @url = ShortenedUrl.sanitize(params[:url])

      if Shortener::ShortenedUrl.where(url: @url, owner: current_user).empty?

        Shortener::ShortenedUrl.generate(@url, owner: current_user, fresh: true, expires_at: 72.hours.since)
        flash[:success] = "L'URL a été transformé avec succès - 1."

      elsif !Shortener::ShortenedUrl.where(url: @url).empty?

        @urls = Shortener::ShortenedUrl.where(url: @url)
        flash[:success] = "L'URL a déjà été ajouté, vous pourrez la trouver ci-dessous."

      else

        Shortener::ShortenedUrl.generate(@url, owner: current_user, expires_at: 72.hours.since)
        flash[:success] = "L'URL a été transformé avec succès - 3."
        redirect_to "/"

      end
    else
    end
  end
end
