module V1
  class CardsController < ApplicationController
    before_action :set_board
    before_action :set_board_card, only: [:show, :update, :destroy]

    def index
      json_response(@board.cards)
    end

    def show
      json_response(@card)
    end

    def create
      @board.cards.create!(card_params)
      json_response(@board, :created)
    end

    def update
      @card.update(card_params)
      head :no_content
    end

    def destroy
      @card.destroy
      head :no_content
    end

    private
      def card_params
        params.permit(:content, :board_id)
      end

      def set_board
        @board = Board.find(params[:board_id])
      end

      def set_board_card
        @card = @board.cards.find(params[:id]) if @board
      end
  end
end
