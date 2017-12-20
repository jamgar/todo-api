require 'rails_helper'

RSpec.describe 'Notes API' do
  let(:user) { create(:user) }
  let!(:board) { create(:board, user_id: user.id) }
  let!(:card) { create(:card, board_id: board.id) }
  let!(:notes) { create_list(:note, 20, card_id: card.id) }
  let(:board_id) { board.id }
  let(:card_id) { card.id }
  let(:id) { notes.first.id }
  let(:headers) { valid_headers }

  describe 'GET /boards/:board_id/cards/:card_id/notes' do
    before { get "/boards/#{board_id}/cards/#{card_id}/notes", params: {}, headers: headers }

    context 'when board card exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all notes' do
        expect(json.size).to eq(20)
      end
    end

    context 'when board does not exist' do
      let(:board_id) { 0 }
      let(:card_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Card/)
      end
    end
  end

  describe 'GET /boards/:board_id/cards/:card_id/notes/:id' do
    before { get "/boards/#{board_id}/cards/#{card_id}/notes/#{id}", params: {}, headers: headers }

    context 'when board card exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the note' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when board note does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Note/)
      end
    end
  end

  describe 'POST /boards/:board_id/cards/:card_id/notes' do
    let(:valid_attributes) { { content: 'Dive to Alantis' }.to_json }

    context 'when request attributes are valid' do
      before { post "/boards/#{board_id}/cards/#{card_id}/notes", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/boards/#{board_id}/cards/#{card_id}/notes", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Content can't be blank/)
      end
    end
  end

  describe 'PUT /boards/:board_id/cards/:card_id/notes/:id' do
    let(:valid_attributes) { { content: 'Swim with Whales' }.to_json }

    before do
      put "/boards/#{board_id}/cards/#{card_id}/notes/#{id}", params: valid_attributes, headers: headers
    end

    context 'when card exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the card' do
        card = Card.find(card_id)
        updated_note = card.notes.find(id)
        expect(updated_note.content).to match(/Swim with Whales/)
      end
    end

    context 'when the note does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Note/)
      end
    end
  end

  describe 'DELETE /boards/:id' do
    before { delete "/boards/#{board_id}/cards/#{card_id}/notes/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
