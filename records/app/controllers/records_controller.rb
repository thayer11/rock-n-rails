class RecordsController < ApplicationController

def index
  @records = Record.all
  # render :index
end

end
