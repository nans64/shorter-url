class ShortenedUrlsController < ApplicationController
    before_action :set_url, only: [:edit, :update, :destroy]

    def index
      @urls = ShortenedUrl.all
    end

    # GET /videos/new
    def new
      @url = ShortenedUrl.new
    end

    def edit
    end

    def create

      if url_params[:url].present?

        @url = ShortenedUrl.sanitize(url_params[:url])

        if ShortenedUrl.where(url: @url, owner_id: current_user).empty?

          Shortener::ShortenedUrl.generate(@url, owner: current_user, fresh: true, expires_at: 72.hours.since)
          flash[:success] = "L'URL a été transformé avec succès"
          redirect_to(root_path)

        elsif ShortenedUrl.where(url: @url).present?

          @urls = ShortenedUrl.where(url: @url)

          if @urls.last.expires_at < DateTime.now && @urls.last.owner_type.nil?
            ShortenedUrl.add_days(@urls.last.id, 3)
          else
            Shortener::ShortenedUrl.generate(@url, owner: current_user, fresh: true, expires_at: 72.hours.since)
          end

          flash[:alert] = "L'URL a déjà été ajouté, vous pourrez la trouver ci-dessous."

          redirect_to static_pages_path(url: @urls.last.id)

        else

          Shortener::ShortenedUrl.generate(@url, owner: current_user, expires_at: 72.hours.since)
          flash[:success] = "L'URL a été transformé avec succès"
          redirect_to(root_path)
        end
      end
    end

    def update

      if url_params[:id] && url_params[:nombre]
        ShortenedUrl.add_days(url_params[:id], url_params[:nombre])
      end

      if url_params[:id] && url_params[:expire_date]
        ShortenedUrl.expire(url_params[:id], url_params[:expire_date])
      end

      respond_to do |format|
        if @url.update(url_params)
          format.html { redirect_to "/users/edit", notice: 'Votre lien a été mis à jour.' }

        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @url.destroy
      respond_to do |format|
        format.html { redirect_to "/users/edit", notice: 'Votre lien a bien été supprimé.' }
        format.json { head :no_content }

      end
    end

    private

    def set_url
      @url = ShortenedUrl.find(params[:id])
    end

    def url_params
      params.require(:shortened_url).permit(:id, :nombre, :url, :expire_date)
    end


end
