require 'rails_helper'

RSpec.describe 'Send API' do
  # Initialize the test data
  let!(:messenger) { create(:messenger) }
  let!(:users) { create_list(:user, 20, messenger_id: messenger.id) }
  let(:messenger_id) { messenger.id }
  let(:id) { users.first.id }

  # Test suite for GET /messengers/:messenger_id/users
  describe 'GET /messengers/:messenger_id/users' do
    before { get "/messengers/#{messenger_id}/users" }

    context 'when messenger exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all messenger users' do
        expect(json.size).to eq(20)
      end
    end

    context 'when messenger does not exist' do
      let(:messenger_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Messenger/)
      end
    end
  end

  # Test suite for GET /messengers/:messenger_id/users/:id
  describe 'GET /messengers/:messenger_id/users/:id' do
    before { get "/messengers/#{messenger_id}/users/#{id}" }

    context 'when messenger user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the user' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when messenger user does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for PUT /messengers/:messenger_id/users
  describe 'POST /messengers/:messenger_id/users' do
    let(:valid_attributes) { { name: 'User 1' } }

    context 'when request attributes are valid' do
      before { post "/messengers/#{messenger_id}/users", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/messengers/#{messenger_id}/users", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /messengers/:messenger_id/users/:id
  describe 'PUT /messengers/:messenger_id/users/:id' do
    let(:valid_attributes) { { name: 'User one' } }

    before { put "/messengers/#{messenger_id}/users/#{id}", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the user' do
        updated_item = User.find(id)
        expect(updated_item.name).to match(/User one/)
      end
    end

    context 'when the item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for DELETE /messengers/:id
  describe 'DELETE /messengers/:id' do
    before { delete "/messengers/#{messenger_id}/users/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end