require 'rails_helper'

RSpec.describe 'The posts show method', :type => :request do

  before do
    @user = create(:user)
    @category = create(:category, title: "Category 1")
    @post = create(:post)
  end

  it "should return the post title and body in JSON" do
    get "categories/#{@category.id}/posts/#{@post.id}", {}, {'Accept' => Mime::JSON}
    expect( response.status ).to eq(200)
    expect( response.content_type ).to eq(Mime::JSON)
    json_response = json(response.body)
    expect( json_response[:post][:title] ).to eq("Post title")
    expect( json_response[:post][:body] ).to eq("Post body")
  end

end