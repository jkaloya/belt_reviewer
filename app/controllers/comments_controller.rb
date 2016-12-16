class CommentsController < ApplicationController

    def create
        @event = Event.find(params[:id])
        @event.comments.create(content: params[:comment][:content], user_id: current_user.id, event: @event)
        redirect_to "/events/#{@event.id}"
    end

    private
    def comments_params
        params.require(:comment).permit(:content, :user_id, :event_id)
    end
end
