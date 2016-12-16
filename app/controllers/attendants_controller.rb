class AttendantsController < ApplicationController
    def create
        event = Event.find( params[:i_id] )
        join = Attending.create(event: event, user: current_user)
        redirect_to "/events"
    end

    def destroy
        event = Event.find( params[:i_id] )
        attending = Attending.find_by(event: event, user: current_user)
        attending.destroy!
        redirect_to "/events"
    end
end
