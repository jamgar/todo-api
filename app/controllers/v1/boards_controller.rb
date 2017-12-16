module V1
  class BoardsController < ApplicationController
    before_action :set_board, only: [:show, :update, :destroy]

    private
      def set_board
        @board = Board.find(params[:id])
      end
  end
end
