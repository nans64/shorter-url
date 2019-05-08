class StaticPagesController < ApplicationController
  def index
    @urls = Shortener::ShortenedUrl.all

    unless params[:url].nil?

      if Shortener::ShortenedUrl.where(url: params[:url], owner: current_user).empty?
        Shortener::ShortenedUrl.generate(params[:url], owner: current_user, fresh: true)
        flash[:success] = "L'URL a été transformé avec succès et attaché à votre compte."

      elsif !Shortener::ShortenedUrl.where(url: params[:url]).empty?

        @urls = Shortener::ShortenedUrl.where(url: params[:url])
        flash[:success] = "L'URL a déjà été ajouté, vous pourrez la trouver ci-dessous."

      else

        Shortener::ShortenedUrl.generate(params[:url], owner: current_user)
        flash[:success] = "L'URL a été transformé avec succès."
        redirect_to "/"

      end

    end
  end
end
