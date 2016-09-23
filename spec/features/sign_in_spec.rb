require "rails_helper"
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

  def user_attributes(overrides = {})
    {
      id: 1,
      email: "william.wallace@scotland.com",
      password: "Testing1"
    }.merge(overrides)
  end

user = User.create!(user_attributes)


describe "Signing in" do
    before(:each) do
        visit root_path
    end

  it "prompts for an email and password" do
    click_link 'Login'
    expect(current_path).to eq(new_user_session_path)
    expect(body).to have_field("user_email")
    expect(body).to have_field("user_password")
  end
  it "signs in the user if the email/password combination is valid" do
    click_link 'Login'
    fill_in "user_email", with: user.reload.email
    fill_in "user_password", with: user.password
    click_button "Log in"
    expect(body).to have_text("#{user.email}")
  end
  it "does not sign in the user if the email/password combination is invalid" do
    click_link 'Login'
    fill_in "user_email", with: user.email
    fill_in "user_password", with: "no match"
    click_button "Log in"
    expect(body).to have_field("user_email")
    expect(body).to have_field("user_password")
  end
  it "signs a user out" do
    click_link 'Login'
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
    click_link 'william.wallace@scotland.com'
    click_link 'Logout'
    expect(body).to have_text("Login")
    expect(body).to have_text("Sign up")
  end
end
