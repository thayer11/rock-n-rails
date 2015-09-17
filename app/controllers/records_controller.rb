class RecordsController < ApplicationController
  def index
    # get all the records
    @records = Record.all
  end

  def show
    # find a specific record
    @record = Record.find(params[:id])
  end

  def new
    # new instance of a record
    @record = Record.new
  end

  def create
    # creating a record in the database
    Record.create(record_params)
    redirect_to('/records')
  end

  private

  # strong parameters for a record
  def record_params
    params.require(:record).permit(:title, :artist, :year, :cover_art, :song_count)
  end

end
