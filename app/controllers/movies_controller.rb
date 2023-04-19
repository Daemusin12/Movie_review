class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :validate_movie_owner, only: [:edit, :update, :destroy]

  def index
    if params.has_key?(:genre)
      @select_genre = params[:genre][:ids]
    else
      @select_genre = Genre.ids
    end
    @movies = Movie.includes(:user, :genres).filtered(@select_genre).page(params[:page]).per(5)
  end

  def shorturl
    @movie = Movie.find_by(short_url: params[:short_url])
    redirect_to movie_path(@movie.id)
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
    @movie.short_url_generator
    if @movie.save
      redirect_to movies_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @movie.update(movie_params)
      redirect_to movies_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end

  private

  def validate_movie_owner
    unless @movie.user == current_user
      flash[:notice] = 'the post not belongs to you'
      redirect_to movies_path
    end
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

 def movie_params
    params.require(:movie).permit(:title, :blurb, :date_released, :country_of_origin, :showing_start, :showing_end, genre_ids: [])
 end
end
