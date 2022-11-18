class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = Bookmark.where(list_id: params[:id])
    movie_ids = []
    @bookmarks.each do |bookmark|
      movie_ids << bookmark.movie_id
    end
    @movies = []
    movie_ids.each do |movie|
      @movies << Movie.find(movie)
    end
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.save

    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
