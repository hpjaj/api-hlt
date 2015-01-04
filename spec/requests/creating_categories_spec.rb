require 'rails_helper'

RSpec.describe 'The categories create method should', :type => :request do

  before do
    @user = create(:user)
  end

  it "create a new category with the proper JSON response content when provided valid user auth_token" do
    post '/categories', 
      {category: 
        { title: "Movies"}
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s, 'Authorization' => "Token token=#{@user.auth_token}" }
  end

  it "does not create a category without a valid user auth_token" do
  end

end