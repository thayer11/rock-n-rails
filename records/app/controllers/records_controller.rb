class RecordsController < ApplicationController

	def create
		Record.create(record_params)
		redirect_to('/records')
	end

	def index
		@records = Record.all
	end

	def new
		@record = Record.new
	end

	def show 
		@record = Record.find(params[:id])
	end

	private 

	def record_params
    	params.require(:record).permit(:title, :artist, :year, :cover_art, :song_count)
  	end
end
