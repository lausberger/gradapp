class AccountsController < ApplicationController
    def new
    end

    def create
        field_data = registration_params
        account_params = field_data.slice(:first, :last, :email, :password, :type)
        @account = Account.new(account_params)
        if @account.save
            # redirect_to root_path, notice: 'Account registration successful'
        else
            flash[:alert] = "Failed to create user account. Please try again."
            render :new
        end
    end

    private
    def registration_params
        params.require(:account).permit(:first, :last, :email, :password, :password_confirm, :type)
    end
end