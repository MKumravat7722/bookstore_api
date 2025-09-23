class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    book = Book.find(params[:book_id])
    comment = book.comments.new(body: params[:body], user: @current_user)
    if comment.save
      render json: comment.as_json(include: { user: { only: [:id, :name] } }), status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
