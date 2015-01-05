require 'rails_helper'

RSpec.describe 'The categories update method', :type => :request do

  before do
    @user = create(:user)
    @category = Category.create!(title: "Favorite Restaurants")
  end

  it "should update an existing category when provided a valid user auth_token" do
    patch "categories/#{@category.id}",
      { category: { title: 'Favorite Movies' } }.to_json,
      json_request_headers(@user.auth_token)

    expect( response.status ).to eq(204)

    get "/categories/#{@category.id}", {}, {'Accept' => Mime::JSON}
    expect( response.status ).to eq(200)
    expect( @category.reload.title ).to eq("Favorite Movies")
    expect( response.content_type ).to eq(Mime::JSON)
  end

  it "should not update an existing category when not provided a valid user auth_token" do
    patch "categories/#{@category.id}",
      { category: { title: 'Favorite Movies' } }.to_json,
      json_request_headers("#{@user.auth_token}+fake")

    expect( response.status ).to eq(401)

    get "/categories/#{@category.id}", {}, {'Accept' => Mime::JSON}
    expect( response.status ).to eq(200)
    expect( @category.reload.title ).to eq("Favorite Restaurants")
    expect( response.content_type ).to eq(Mime::JSON)
  end

end