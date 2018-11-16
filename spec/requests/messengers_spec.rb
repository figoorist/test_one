require 'rails_helper'

RSpec.describe 'Messengers API', type: :request do
  # initialize test data 
  let!(:messengers) { create_list(:messenger, 10) }
  let(:messenger_id) { messengers.first.id }

  # Test suite for GET /todos
  describe 'GET /messengers' do
    # make HTTP get request before each example
    before { get '/messengers' }

    it 'returns messengers' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /todos/:id
  describe 'GET /messengers/:id' do
    before { get "/messengers/#{messenger_id}" }

    context 'when the record exists' do
      it 'returns the messenger' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(messenger_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:messenger_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Messenger/)
      end
    end
  end

  # Test suite for POST /todos
  describe 'POST /messengers' do
    # valid payload
    let(:valid_attributes) { { name: 'Telegram' } }

    context 'when the request is valid' do
      before { post '/messengers', params: valid_attributes }

      it 'creates a todo' do
        expect(json['name']).to eq('Telegram')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/messengers', params: { name: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /todos/:id
  describe 'PUT /messengers/:id' do
    let(:valid_attributes) { { title: "What's up" } }

    context 'when the record exists' do
      before { put "/messengers/#{messenger_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /messengers/:id' do
    before { delete "/messengers/#{messenger_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end