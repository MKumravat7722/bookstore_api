class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    book = Book.find(params[:book_id])
    comment = book.comments.new(body: params[:body], user: @current_user)
    if comment.save
      render json: CommentSerializer.new(comment).serializable_hash, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
