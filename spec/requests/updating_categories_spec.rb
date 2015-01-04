require 'rails_helper'

RSpec.describe 'The categories update method should', :type => :request do

  before do
    @user = create(:user)
    @category = Category.create!(title: "Favorite Restaurants")
  end

  it "update an existing category when provided a valid user auth_token" do
    patch "categories/#{@category.id}",
      { category: { title: 'Favorite Movies' } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => "Token token=#{@user.auth_token}" }

  end

  it "should not update an existing category when not provided a valid user auth_token" do

  end

end