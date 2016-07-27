class RecordsController < ApplicationController

def index
  @records = Record.all
  # render :index
end

def show
    @record = Record.find(params[:id])
    render :show #optional
end

def new
    @record = Record.new
    render :new #optional
end

def create
    Record.create(record_params)
    redirect_to('/records')
end

private

  def record_params
    params.require(:record).permit(:title, :artist, :year, :conver_art, :song_count)
  end
end # end of class

