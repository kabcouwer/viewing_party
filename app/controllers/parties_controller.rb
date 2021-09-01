class PartiesController < ApplicationController
  def new
    @duration = params[:duration]
    @movie = MovieFacade.find_movie(params[:id])
    @party = Party.new
    # require "pry"; binding.pry
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

  def redirect_with_params
    # redirect_to controller: 'attendees', action:
    # new_party_path({ movie_title: params[:party][:movie_title], duration: params[:duration],
    #                              id: params[:id] })
  end

  # def invite_attendee(party)
  #   params[:party][:attendees].each do |attendee|
  #     party.attendees.create(friend_id: attendee) if attendee != ''
  #   end
  # end
end
