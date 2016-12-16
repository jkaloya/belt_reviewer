class UsersController < ApplicationController
    before_action :require_login, except: [:index, :create]
    before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

    def index
        @states = [('AL'), ('AK'), ('AZ'), ('AR'), ('CA'), ('CO'), ('CT'), ('DE'), ('DC'), ('FL'), ('GA'), ('HI'), ('ID'), ('IL'), ('IN'), ('IA'), ('KS'), ('KY'), ('LA'), ('ME'), ('MD'), ('MA'), ('MI'), ('MN'), ('MS'), ('MO'), ('MT'), ('NE'), ('NV'), ('NH'), ('NJ'), ('NM'), ('NY'), ('NC'), ('ND'), ('OH'), ('OK'), ('OR'), ('PA'), ('PR'), ('RI'), ('SC'), ('SD'), ('TN'), ('TX'), ('UT'), ('VT'), ('VA'), ('WA'), ('WV'), ('WI'), ('WY')]
    end

    def create
        if params[:user][:password] == params[:user][:password_confirmation]
            @user = User.new( user_params )
            if !@user.valid?
                initialize_flash
                flash[:errors] = @user.errors.full_messages
                redirect_to "/"
            else
                @user.save
                session[:user_id] = @user.id
                redirect_to "/events"
            end
        else
            initialize_flash
            flash[:errors] << "Password does not match Password Confirmation"
            redirect_to "/"
        end
    end

    def edit
        @user = User.find( params[:id] )
        @states = [('AL'), ('AK'), ('AZ'), ('AR'), ('CA'), ('CO'), ('CT'), ('DE'), ('DC'), ('FL'), ('GA'), ('HI'), ('ID'), ('IL'), ('IN'), ('IA'), ('KS'), ('KY'), ('LA'), ('ME'), ('MD'), ('MA'), ('MI'), ('MN'), ('MS'), ('MO'), ('MT'), ('NE'), ('NV'), ('NH'), ('NJ'), ('NM'), ('NY'), ('NC'), ('ND'), ('OH'), ('OK'), ('OR'), ('PA'), ('PR'), ('RI'), ('SC'), ('SD'), ('TN'), ('TX'), ('UT'), ('VT'), ('VA'), ('WA'), ('WV'), ('WI'), ('WY')]
    end

    def destroy
        user = User.find( params[:id] )
        user.destroy!
        session[:user_id] = nil
        redirect_to "/"
    end

    def update
        @user = User.find( params[:id] )
        @user.update(first_name: user_params[:first_name], last_name: user_params[:last_name], email: user_params[:email], location: user_params[:location], state: user_params[:state])
        if @user.update(first_name: user_params[:first_name], last_name: user_params[:last_name], email: user_params[:email], location: user_params[:location], state: user_params[:state])
            redirect_to "/users/#{@user.id}"
        else
            flash[:errors] = []
            flash[:errors] = @user.errors.full_messages
            redirect_to "/users/#{@user.id}"
        end
    end

    private
    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :location, :state, :password)
    end
end
