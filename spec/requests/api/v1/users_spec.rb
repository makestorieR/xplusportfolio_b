require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  include ApiDoc::V1::Users::Api

  before do 

    10.times do |n|
      create :user, name: "name#{n}", email: "me#{n}@gmail.com", password: "password"
    end

  end

  describe "GET /index" do
    #include ApiDoc::V1::Users::Index

    before do 
      get '/api/v1/users'
      
      @json_data = JSON.parse(response.body)
    end

    it "returns list of users" do
      expect(@json_data.first).to include({
        'name' => 'name0'
      })  
    end
    
    
  end
end
