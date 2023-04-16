class MoviesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :validate_movie_owner, only: [:edit, :update, :destroy]

  def index
    @movies = Movie.includes(:user).all
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.user = current_user
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
    params.require(:movie).permit(:title, :blurb, :date_released, :country_of_origin, :showing_start, :showing_end)
 end
end
