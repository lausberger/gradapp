require 'spec_helper'
require 'rails_helper'

describe AccountsController do
    describe 'creating an account' do
        before(:each) do 
            @account = {
                :first => "Lucas", 
                :last => "Ausberger", 
                :email => "lausberger@uiowa.edu", 
                :password => "password", 
                :password_confirm => "password", 
                :type => "Student"
            }
        end

        context 'with valid info' do
            it 'should redirect to home page' do
                post :register, {:account => @account}
                expect(response).to render_template root_path 
            end
            it 'should flash a success message' do 
                expect(flash[:notice]).to eq "Account created successfully"
            end
        end

        context 'with invalid info' do
            context 'non-matching passwords' do
                before(:each) do
                    @account[:password_confirm] = "different"
                end
                it 'should redirect back to registration page' do
                    post :register, {:account => @account}
                end
                it 'should flash an alert with an explanation' do
                    expect(flash[:alert]).to eq "Passwords do not match"
                end
            end

            context 'empty fields' do
                before(:each) do
                    @account[:last_name] = ""
                end
                it 'should redirect back to registration page' do
                    post :register, {:account => @account}
                    expect(response).to render_template register_path
                end
                it 'should flash an alert with an explanation' do
                    expect(flash[:alert]).to eq "Please fill out the following fields: First Name"
                end
            end
        end
    end

    describe 'logging in' do
        before(:each) do 
            @account = {
                :first_name => "Lucas", 
                :last_name => "Ausberger", 
                :email => "lausberger@uiowa.edu", 
                :password => "password", 
                :password_confirm => "password", 
                :type => "Student"
            }
            post :register, {:account => @account}
        end

        context 'with correct information' do
            it 'should redirect back to home page' do
                post :login, {:credentials => {:email => @account[:email], :password => @account[:password]}}
                expect(response).to redirect_to root_path
            end
            it 'should flash a success notice' do
                expect(flash[:notice]).to eq "Welcome, #{@account[:first_name]}."
            end
        end

        context 'with incorrect information' do
            it 'should redirect back to login page' do
                post :login, {:credentials => {:email => "bademail@mail.com", :password => @account[:password]}}
                expect(response).to redirect_to login_path
            end
            it 'should flash an alert informing the user of incorrect credentials' do
                expect(flash[:alert]).to eq "Incorrect email or password"
            end
        end

        context 'with invalid information' do
            context 'missing email' do
                it 'should redirect back to login page' do
                    post :login, {:credentials => {:email => "", :password => @account[:password]}}
                    expect(response).to redirect_to login_path
                end
                it 'should inform the user of an empty email field' do
                    expect(flash[:notice]).to eq "Email field cannot be empty"
                end
            end

            context 'invalid email' do
                it 'should redirect back to login page' do
                    post :login, {:credentials => {:email => "lausberger", :password => @account[:password]}}
                    expect(response).to redirect_to login_path
                end
                it 'should inform the user of an invalid email' do
                    expect(flash[:notice]).to eq "Please provide a valid email address"
                end
            end

            context 'missing password' do
                it 'should redirect back to login page' do
                    post :login, {:credentials => {:email => @account[:email], :password => ""}}
                    expect(response).to redirect_to login_path
                end
                it 'should inform the user of an empty password field' do
                    expect(flash[:notice]).to eq "Password field cannot be empty"
                end
            end
        end
    end
end