class AttendeesController < ApplicationController
  def create
    party_id = params[:party_id]
    host = Attendee.create(user_id: current_user.id, party_id: party_id, host_status: true)
    attendees_ids = params[:party][:attendees].keys
    if !attendees_ids.nil?
      attendees_ids.each do |id|
        Attendee.create(user_id: id, party_id: party_id)
      end
    end
    redirect_to dashboard_path
  end
end
