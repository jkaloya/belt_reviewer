class EventsController < ApplicationController

    def create
        t = Time.now()
        t.to_s
        if params[:event][:date] > t
            @user = User.find( current_user )
            @user.events.create(events_params)
            redirect_to "/events"
        else
            initialize_flash
            flash[:errors] << "Event must be in the future"
            redirect_to "/events"
        end
    end

    def index
        @user = current_user
        @event_in_state = Event.where(state: current_user.state)
        @event_not_in_state = Event.where.not(state: current_user.state)
        @states = [('AL'), ('AK'), ('AZ'), ('AR'), ('CA'), ('CO'), ('CT'), ('DE'), ('DC'), ('FL'), ('GA'), ('HI'), ('ID'), ('IL'), ('IN'), ('IA'), ('KS'), ('KY'), ('LA'), ('ME'), ('MD'), ('MA'), ('MI'), ('MN'), ('MS'), ('MO'), ('MT'), ('NE'), ('NV'), ('NH'), ('NJ'), ('NM'), ('NY'), ('NC'), ('ND'), ('OH'), ('OK'), ('OR'), ('PA'), ('PR'), ('RI'), ('SC'), ('SD'), ('TN'), ('TX'), ('UT'), ('VT'), ('VA'), ('WA'), ('WV'), ('WI'), ('WY')]
    end

    def show
        @event = Event.find( params[:id] )
        @attendants = @event.users_attending
        @comments = @event.comments
    end

    def edit
        @event = Event.find( params[:id] )
        @states = [('AL'), ('AK'), ('AZ'), ('AR'), ('CA'), ('CO'), ('CT'), ('DE'), ('DC'), ('FL'), ('GA'), ('HI'), ('ID'), ('IL'), ('IN'), ('IA'), ('KS'), ('KY'), ('LA'), ('ME'), ('MD'), ('MA'), ('MI'), ('MN'), ('MS'), ('MO'), ('MT'), ('NE'), ('NV'), ('NH'), ('NJ'), ('NM'), ('NY'), ('NC'), ('ND'), ('OH'), ('OK'), ('OR'), ('PA'), ('PR'), ('RI'), ('SC'), ('SD'), ('TN'), ('TX'), ('UT'), ('VT'), ('VA'), ('WA'), ('WV'), ('WI'), ('WY')]
    end

    def update
        @event = Event.find( params[:id] )
        @event.update(name: events_params[:name], date: events_params[:date], location: events_params[:location], state: events_params[:state])
        if @event.update(name: events_params[:name], date: events_params[:date], location: events_params[:location], state: events_params[:state])
            redirect_to "/events"
        else
            initialize_flash
            flash[:errors] = @event.errors.full_messages
            redirect_to "/events/#{@event.id}"
        end

    end

    def destroy
        event = Event.find( params[:id] )
        event.destroy if event.user == current_user
        redirect_to "/events"
    end

    private
    def events_params
        params.require(:event).permit(:name, :date, :location, :state, :user)
    end
end
