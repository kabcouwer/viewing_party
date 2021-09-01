class Parties < ApplicationController
  before_action :require_login, only: %i[new create]

  def new
    @movie_title = params[:movie_title]
    @duration = params[:duration]
    @party = Party.new
  end

  def create
    party = current_user.parties.new(party_params)
    if params[:party][:attendees].nil?
      flash[:error] = 'Error: Party must include friends.'
      # some redirect here?
    elsif params[:party][:duration] < params[] # << movie runtime?
      flash[:error] = 'Error: Party duration must match or exceed movie length.'
      # some redirect here?
    elsif party.save
      params[:party][:attendees].each do |attendee|
        party.attendees.create(friend_id: attendee) if attendee != ''
      end
      redirect_to dashboard_path
    end
  end

  private

  def party_params
    params.require(:party).permit(:movie_title, :duration, :day, :start_time)
  end

  # for potential refactor
  # def create_inviation(party)
  # end
end
