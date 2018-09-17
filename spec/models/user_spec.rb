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

    it "must have a password with minimum 8 characters" do
      @user = User.new({first_name: "Vincent", last_name: "Ly", email: "vincent@vincent.com", password: "under8", password_confirmation: "under8"})
      @user.save
      expect(@user.errors.full_messages).to include "Password is too short (minimum is 8 characters)"
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

  describe ".authenticate_with_credentials" do
    it "should return user when correct parameters are passed" do
      @user = User.create({first_name: "Chris",last_name: "Lo", email: "chris@chris.com", password: "password", password_confirmation: "password"})
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end

    it "should return nil when incorrect email is passed" do
      @user = User.create({first_name: "Chris",last_name: "Lo", email: "chris@chris.com", password: "password", password_confirmation: "password"})
      expect(User.authenticate_with_credentials("incorrect_email", @user.password)).to eq(nil)
    end

    it "should return nil when incorrect password is passed" do
      @user = User.create({first_name: "Chris",last_name: "Lo", email: "chris@chris.com", password: "password", password_confirmation: "password"})
      expect(User.authenticate_with_credentials(@user.email, "incorrect_password")).to eq(nil)
    end

    it "should return user regardless of spacing before & after" do
      @user = User.create({first_name: "Chris",last_name: "Lo", email: "chris@chris.com", password: "password", password_confirmation: "password"})
      expect(User.authenticate_with_credentials("    #{@user.email}", @user.password)).to eq(@user)
    end

    it "should return user regardless of casing for email" do
      @user = User.create({first_name: "Chris",last_name: "Lo", email: "chris@chris.com", password: "password", password_confirmation: "password"})
      expect(User.authenticate_with_credentials(@user.email.upcase, @user.password)).to eq(@user)
    end
  end

end
