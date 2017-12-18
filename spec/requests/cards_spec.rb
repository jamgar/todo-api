require 'rails_helper'

RSpec.describe 'Cards API' do
  let(:user) { create(:user) }
  let!(:board) { create(:board, user_id: user.id) }
  let!(:cards) { create_list(:card, 20, board_id: board.id) }
  let(:board_id) { board.id }
  let(:id) { cards.first.id }
  let(:headers) { valid_headers }

  describe 'GET /boards/:board_id/cards' do
    before { get "/boards/#{board_id}/cards", params: {}, headers: headers }

    context 'when board exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all board cards' do
        expect(json.size).to eq(20)
      end
    end

    context 'when board does not exist' do
      let(:board_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Board/)
      end
    end
  end

  describe 'GET /boards/:board_id/cards/:id' do
    before { get "/boards/#{board_id}/cards/#{id}", params: {}, headers: headers }

    context 'when board card exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the card' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when board card does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Card/)
      end
    end
  end

  describe 'POST /boards/:board_id/cards' do
    let(:valid_attributes) { { title: 'Visit Narina' }.to_json }

    context 'when request attributes are valid' do
      before { post "/boards/#{board_id}/cards", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/boards/#{board_id}/cards", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'PUT /boards/:board_id/cards/:id' do
    let(:valid_attributes) { { title: 'Mozart' }.to_json }

    before do
      put "/boards/#{board_id}/cards/#{id}", params: valid_attributes, headers: headers
    end

    context 'when card exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the card' do
        updated_card = Card.find(id)
        expect(updated_card.title).to match(/Mozart/)
      end
    end

    context 'when the card does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Card/)
      end
    end
  end

  describe 'DELETE /boards/:id' do
    before { delete "/boards/#{board_id}/cards/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
