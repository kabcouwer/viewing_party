class PartiesController < ApplicationController
  before_action :require_login, only: %i[new create]

  def new
    # @duration = params[:duration]
    @movie = MovieFacade.find_movie(params[:id])
    @party = Party.new
  end

  def create
    new_party = current_user.parties.new(party_params)
    if new_party && new_party.save
      redirect_to :controller => 'attendees', :action => 'create', party_id: new_party.id, params: request.parameters
    else
      flash[:error] = new_party.errors.full_messages.to_sentence
    end
  end

  private

  def party_params
    params.require(:party).permit(:movie_title, :duration, :day, :start_time, :id)
  end
end
