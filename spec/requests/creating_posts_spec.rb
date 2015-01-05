require 'rails_helper'

RSpec.describe 'The posts create method', :type => :request do

  before do
    @user = create(:user)
    @category = create(:category)
  end

  it "should create a new post with the proper JSON response content when provided valid user auth_token" do
    post "/categories/#{@category.id}/posts/", 
      {post: 
        { title: "Post title 1", body: "Post body 1"}
      }.to_json,
      json_request_headers(@user.auth_token)

    expect( response.status ).to eq(201)
    expect( response.content_type ).to eq(Mime::JSON)
    json_response = json(response.body)
    expect(json_response[:title]).to eq "Post title 1"
    expect(json_response[:body]).to eq "Post body 1"
  end

  it "does not create a post without a valid user auth_token" do
    post "/categories/#{@category.id}/posts/", 
      {post: 
        { title: "Post title 1", body: "Post body 1"}
      }.to_json,
      json_request_headers("#{@user.auth_token}+fake")

    expect( response.content_type ).to eq(Mime::JSON)
    expect( response.status ).to eq(401)
    expect( response.body ).to_not include("Post title 1")
    expect( response.body ).to_not include("Post body 1")
  end

end