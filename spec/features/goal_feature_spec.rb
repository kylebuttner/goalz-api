require 'rails_helper'

describe 'Goals', type: :request do
  let(:parsed_response) { JSON.parse(response.body) }

  describe 'GET /goals' do
    before :each do
      FactoryGirl.create_list(:goal, 3)
    end

    it 'returns all goals' do
      get('/goals', {}, { 'Accept': 'application/json' })

      expect(response.status).to eq 200

      expect(parsed_response[0]['name']).to eq("FactoryGoalName")
      expect(parsed_response.length).to eq(3)
    end
  end
  
  describe 'POST/movies' do 
    it 'creates a goal' do 
    
      goal_params = {name: "Learn piano"}.to_json

      request_headers = {
        "Accept" => "application/json",
        "Content-Type" => "application/json"
      }

      post("/goals", goal_params, request_headers)

      expect(response.status).to eq 201
      expect(Goal.first.name).to eq("Learn piano")
    end
  end
end