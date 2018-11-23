require 'rails_helper'

RSpec.describe 'Users API' do

  # Initialize the test data
  let!(:messengers) { create_list(:messenger_with_users, 3) }
  let(:user_id) { messengers.first.users.first.id }
  let(:text) { Faker::Lorem.sentence }
  let(:date) { DateTime.now }
  
  # POST /send
  describe 'POST /send' do
    # valid payload
    let(:valid_attributes) { { user_id: user_id, text: text, date: date } }

    context 'when the request is valid' do
      before { post '/send', params: valid_attributes }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns messenger name' do
        expect(json['messenger']).to eq(messengers.first.name)
      end
      
    end

    context "when user doesn\'t exist" do
      before { post '/send', params: valid_attributes.merge(user_id: 0) }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/User doesn\'t exist/)
      end
    end

    context 'when there is empty message' do
      before { post '/send', params: valid_attributes.merge(text: "") }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Text can't be empty/)
      end
    end

    context 'when there is invalid date' do
      before { post '/send', params: valid_attributes.merge(date: "date") }

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