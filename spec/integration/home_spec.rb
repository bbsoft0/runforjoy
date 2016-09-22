require 'rails_helper'

describe 'home page' do
  it 'welcomes the user' do
    visit '/'
    #page.expect have_content('Login or SIgn Up to add new segments')

    expect(page).to have_content('Login or SIgn Up to add new segments')
  end
end
