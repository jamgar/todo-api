require 'rails_helper'

RSpec.describe 'Boards API', type: :request do
  let(:user) { create(:user) }
  let!(:boards) { create_list(:board, 5, user_id: user.id) }
  let(:board_id) { boards.first.id }
  let(:headers) { valid_headers }

  describe 'GET /boards' do
    before { get '/boards', params: {}, headers: headers }

    it 'returns boards' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /boards/:id' do
    before { get "/boards/#{board_id}", params: {}, headers: headers }

    context 'when the record does not exist' do
      let(:board_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Board/)
      end
    end
  end

  describe 'POST /boards' do
    let(:valid_attributes) do
      { title: 'Learn Elm' }.to_json
    end

    context 'when the request is valid' do
      before { post '/boards', params: valid_attributes, headers: headers }

      it 'creates a board' do
        expect(json['title']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:valid_attributes) { { title: nil }.to_json }
      before { post '/boards', params: valid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /boards/:id' do
    let(:valid_attributes) { { title: 'Shopping' }.to_json }

    context 'when the record exists' do
      before { put "/boards/#{board_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /boards/:id' do
    before { delete "/boards/#{board_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
