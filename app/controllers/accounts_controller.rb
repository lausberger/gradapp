class AccountsController < ApplicationController
    def new
    end

    # add a show method and view
    # def show
    # end

    def create
        field_data = registration_params
        if field_data.any? { |k,v| v.blank? }
            flash[:warning] = "Fields cannot be empty"
        else
            if field_data[:password] != field_data[:password_confirm]
                flash[:warning] = "Passwords do not match"
            else
                if field_data[:email] !~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
                    flash[:warning] = "Please enter a valid email address"
                else
                    account_params = field_data.slice(:first_name, :last_name, :email, :password, :type)
                    @account = Account.new(account_params)
                    if @account.save
                        flash[:notice] = "Account registration successful"
                        redirect_to root_path and return
                    else
                        if Account.where(email: @account.email)
                            flash[:warning] = "An account with that email already exists"
                        else
                            flash[:alert] = "Account registration failed, please try again."
                        end
                    end
                end
            end
        end
        # if we reach this line, something has gone wrong
        render :new
    end

    private
    def registration_params
        params.require(:account).permit(:first_name, :last_name, :email, :password, :password_confirm, :type)
    end
end