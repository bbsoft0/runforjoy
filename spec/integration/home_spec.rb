require 'rails_helper'

describe 'home page' do
  it 'welcomes the user' do
    visit '/'
    expect(page).to have_content('Login or SIgn Up to add new segments')
  end
end
