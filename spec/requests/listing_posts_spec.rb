require 'rails_helper'

RSpec.describe 'The categories show method', :type => :request do

  before do
    @user = create(:user)
    @category1 = create(:category, title: "Category 1")
    @category2 = create(:category, title: "Category 2")
    @post1 = create(:post, title: "Post one", category: @category1)
    @post2 = create(:post, title: "Post two", category: @category1)
    @post3 = create(:post, title: "Post three", category: @category2)
  end

  it "should return all of the posts associated with a given category in JSON" do
    get "/categories/#{@category1.id}", {}, {'Accept' => Mime::JSON}
    expect( response.status ).to eq(200)
    expect( response.content_type ).to eq(Mime::JSON)
    json_response = json(response.body)
    expect( json_response[0][:category_title] ).to eq("Category 1")
    expect( json_response[1][:category_title] ).to eq("Category 1")
    expect( json_response[0][:post_title] ).to eq("Post one")
    expect( json_response[1][:post_title] ).to eq("Post two")
    expect( json_response[0][:post_title] ).to_not eq("Post three")
    expect( json_response[1][:post_title] ).to_not eq("Post three")
  end

end