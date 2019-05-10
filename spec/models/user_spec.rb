require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do

    before(:each) do
      @user = User.create!(email: "jean@highflyers.agency", password:"123456", password_confirmation: "123456")
    end

    context "validation" do

      it "is valid with valid attributes" do
        expect(@user).to be_a(User)
        expect(@user).to be_valid
      end
  end

  end
end
