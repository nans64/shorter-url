class StaticPagesController < ApplicationController
    before_action :set_url, only: [:edit, :update, :destroy]

    def index
      @urls = ShortenedUrl.all
      @url = ShortenedUrl.new
    end

    # GET /videos/new
    def new
    end

    def show
    end


    def edit
    end

    def create

      if ShortenedUrl.is_not_empty?(params[:url])

        @url = ShortenedUrl.sanitize(params[:url])

        if ShortenedUrl.where(url: @url, owner: current_user).empty?

          Shortener::ShortenedUrl.generate(@url, owner: current_user, fresh: true, expires_at: 72.hours.since)

        elsif !ShortenedUrl.where(url: @url).empty?

        else

          Shortener::ShortenedUrl.generate(@url, owner: current_user, expires_at: 72.hours.since)

        end

      end

      if @url.save
        redirect_to(root_path)
        flash[:success] = "L'URL a été transformé avec succès."
      else
        redirect_to(root_path)
        @urls = ShortenedUrl.where(url: @url)
        flash[:alert] = "L'URL a déjà été ajouté, vous pourrez la trouver ci-dessous."
      end

    end

    def update

      if params[:id] && params[:nombre]
        ShortenedUrl.add_days(params[:id], params[:nombre])
      end

      if params[:id] && params[:date]
        ShortenedUrl.expire(params[:id], params[:date])
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
