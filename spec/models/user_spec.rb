require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "must have a password" do
      @user = User.new({first_name: "Chris",last_name: "Lo", email: "chris@chris.com", password: nil, password_confirmation: "password"})
      @user.save
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it "must have matching password & password confirmation" do
      @user = User.new({first_name: "Andrew", last_name: "Hsieh", email: "andrew@andrew.com", password: "password", password_confirmation: ""})
      @user.save
      expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
    end

    it "must have a unique email" do
      @user1 = User.create({first_name: "Chris",last_name: "Lo", email: "chris@chris.com", password: "password", password_confirmation: "password"})
      @user2 = User.new({first_name: "Ryan",last_name: "Reynolds", email: "chris@chris.com", password: "password", password_confirmation: "password"})
      @user2.save
      expect(@user2.errors.full_messages).to include "Email has already been taken"
   end

    it "must have case insensitive email field" do
      @user1 = User.create({first_name: "Chris",last_name: "Lo", email: "chris@chris.com", password: "password", password_confirmation: "password"})
      @user2 = User.new({first_name: "Ryan",last_name: "Reynolds", email: "CHRIS@CHRIS.COM", password: "password", password_confirmation: "password"})
      @user2.save
      expect(@user2.errors.full_messages).to include "Email has already been taken"
    end
  end
end
