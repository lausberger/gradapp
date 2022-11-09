class AccountsController < ApplicationController
    def new
    end

    def create
        field_data = registration_params
        if field_data[:password] == field_data[:password_confirm]
            account_params = field_data.slice(:first, :last, :email, :password, :type)
            @account = Account.new(account_params)
            if @account.save
                flash[:notice] = "Account registration successful"
                redirect_to root_path
            else
                flash[:alert] = "Account registration failed, please try again."
                render :new
            end
        else
            flash[:alert] = "Passwords do not match"
            redirect :new
        end
    end

    private
    def registration_params
        params.require(:account).permit(:first, :last, :email, :password, :password_confirm, :type)
    end
end