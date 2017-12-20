module V1
  class NotesController < ApplicationController
    before_action :set_card
    before_action :set_card_note, only: [:show, :update, :destroy]

    def index
      json_response(@card.notes)
    end

    def show
      json_response(@note)
    end

    def create
      @note = @card.notes.create!(note_params)
      json_response(@note, :created)
    end

    def update
      @note.update(note_params)
      head :no_content
    end

    def destroy
      @note.destroy
      head :no_content
    end

    private
      def note_params
        params.permit(:content, :card_id)
      end

      def set_card
        @card = Card.find(params[:card_id])
      end

      def set_card_note
        @note = @card.notes.find(params[:id]) if @card
      end
  end
end
