require 'rails_helper'

RSpec.describe 'Users API' do

  # Initialize the test data
  let!(:messengers) { create_list(:messenger_with_users, 3) }
  let(:user) { messengers.first.users.first }
  let(:user_id) { messengers.first.users.first.id }
  let(:text) { Faker::Lorem.sentence }
  let(:date) { DateTime.now }
  # authorize request
  let(:headers) { valid_headers }
  
  # POST /send
  describe 'POST /send' do

    context 'when the request is valid' do

      # valid payload
      let(:valid_attributes) { { user_id: user_id, text: text, date: date }.to_json }

      before { post '/send', params: valid_attributes, headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns messenger name' do
        expect(json['messenger']).to eq(messengers.first.name)
      end
      
    end

    context "when user doesn\'t exist" do

      # invalid payload
      let(:invalid_attributes) { { user_id: 0, text: text, date: date }.to_json }

      before { post '/send', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/User doesn\'t exist/)
      end
    end

    context 'when there is empty message' do

      # invalid payload
      let(:invalid_attributes) { { user_id: user_id, text: "", date: date }.to_json }

      before { post '/send', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Text can't be empty/)
      end
    end

    context 'when there is invalid date' do

      # invalid payload
      let(:invalid_attributes) { { user_id: user_id, text: text, date: "date" }.to_json }

      before { post '/send', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Invalid date/)
      end
    end
  end
end