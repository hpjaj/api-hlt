require 'rails_helper'

RSpec.describe 'The categories create method', :type => :request do

  before do
    @user = create(:user)
  end

  it "should create a new category with the proper JSON response content when provided valid user auth_token" do

    post '/categories', 
      {category: 
        { title: "Movies"}
      }.to_json,
      json_request_headers(@user.auth_token)
      
    expect( response.status ).to eq(201)
    expect( response.content_type ).to eq(Mime::JSON)
    json_response = json(response.body)
    expect(json_response[:title]).to eq "Movies"
  end

  it "does not create a category without a valid user auth_token" do
    post '/categories', 
      {category: 
        { title: "Movies"}
      }.to_json,
      json_request_headers("#{@user.auth_token}+fake")
      
    expect( response.content_type ).to eq(Mime::JSON)
    expect( response.status ).to eq(401)
    expect( response.body ).to_not include("Movies")
  end

  
end