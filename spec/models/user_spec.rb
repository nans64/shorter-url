require 'rails_helper'

describe "the signin process", type: :feature do

    before(:each) do
      @user = User.create!(email: "jean@highflyers.agency", password:"123456", password_confirmation: "123456")
    end

    context "validation" do

      it "is valid with valid attributes" do
        expect(@user).to be_a(User)
        expect(@user).to be_valid
      end
    end

    it "signs me in" do
      visit user_session_path
      within('form') do
        fill_in 'input-email', with: 'jean@highflyers.agency'
        fill_in 'input-password', with: '123456'
      end
      click_button 'input-submit'
      expect(page).to have_content 'Signed in successfully'
    end



end
