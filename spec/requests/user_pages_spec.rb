require 'spec_helper'

describe "UserPages" do
	subject{page}

	describe "signup page" do

		before {visit signup_path}

		it {should have_content('Sign up')}
		it {should have_title(full_title('Sign Up'))}

		let(:submit) { "Create my account"}

		describe "when the information is invalid" do
			it "should not create a user" do
				expect{ click_button submit }.not_to change(User, :count)
			end
		end

		describe "when the information is valid" do

			before do
				fill_in "Name", with:"Example"
				fill_in "Email", with:"example@hotmail.com"
				fill_in "Password", with:"foobar"
				fill_in "Confirmation", with:"foobar"
			end

			it "should create a user" do
				expect{ click_button submit}.to change(User, :count).by(1)
			end
		end

		describe "the signup page after a failed signup" do

			before do
				fill_in "Name", with: "Example"
				fill_in "Email", with: "somethingwrong"
				click_button submit
			end

			it { should have_content('Email is invalid')}

		end


  	end

  	describe "profile page" do

		let(:user) { FactoryGirl.create(:user) }

		before { visit user_path(user)}

		it {should have_title(user.name)}
		it {should have_content(user.name)}
	end
end


