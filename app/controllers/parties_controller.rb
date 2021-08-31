class Parties < ApplicationController
  def new
    @movie_title = params[:movie_title]
    @duration = params[:duration]
    @pary = Party.new
  end
end
