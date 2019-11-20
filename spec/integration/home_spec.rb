require 'rails_helper'

describe 'home page' do
    before(:each) do
        visit root_path
    end

    it 'welcomes the user' do
      visit '/'
      expect(page).to have_content('Login or SIgn Up to add new segments')
    end

    it "should have Segments List" do
        click_link 'Segments List'
        expect(page).to have_content('Segments')
    end

    it "should have Explore" do
        # click_link 'Explore'
        # expect(page).to have_content('Routing Error')
    end

    it "should have Sign Up link" do
        click_link "Sign up"
        expect(page).to have_content('Sign Up')
    end

end
