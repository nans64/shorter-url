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

      if ShortenedUrl.is_not_empty?(url_params[:url])

        @url = ShortenedUrl.sanitize(url_params[:url])

        if ShortenedUrl.where(url: @url, owner_id: current_user).empty?

          Shortener::ShortenedUrl.generate(@url, owner: current_user, fresh: true, expires_at: 72.hours.since)
          flash[:success] = "L'URL a été transformé avec succès - 1."
          redirect_to(root_path)

        elsif !ShortenedUrl.where(url: @url).empty?

          @urls = ShortenedUrl.where(url: @url)
          flash[:success] = "L'URL a déjà été ajouté, vous pourrez la trouver ci-dessous."

          redirect_to static_pages_path(url: @urls.last.id) # ne fonctionne pas
        else

          Shortener::ShortenedUrl.generate(@url, owner: current_user, expires_at: 72.hours.since)
          flash[:success] = "L'URL a été transformé avec succès - 3."
          redirect_to(root_path)
        end
      end
    end

    def update
      byebug
      if url_params[:id] && url_params[:nombre]
        ShortenedUrl.add_days(url_params[:id], url_params[:nombre])
      end

      if url_params[:id] && url_params[:date]
        ShortenedUrl.expire(url_params[:id], url_params[:date])
      end

      respond_to do |format|
        if @url.update(video_params)
          format.html { redirect_to "/", notice: 'Video was successfully updated.' }

        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @url.destroy
      respond_to do |format|
        format.html { redirect_to videos_url, notice: 'Video was successfully destroyed.' }
        format.json { head :no_content }
        redirect_to "/"

      end
    end

    private

    def set_url
      @url = ShortenedUrl.find(params[:id])
    end

    def url_params
      params.require(:shortened_url).permit(:id, :nombre, :url)
    end


end
