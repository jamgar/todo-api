module V1
  class BoardsController < ApplicationController
    before_action :set_board, only: [:show, :update, :destroy]

    def index
      @boards = current_user.boards
      json_response(@boards)
    end

    def show
      json_response(@board)
    end

    def create
      @board = current_user.boards.create!(board_params)
      json_response(@board, :created)
    end

    def update
      @board.update(board_params)
      json_response(@board)
    end

    def destroy
      @board.destroy
      head :no_content
    end

    private
      def board_params
        params.permit(:title, :user_id)
      end

      def set_board
        @board = Board.find(params[:id])
      end
  end
end
