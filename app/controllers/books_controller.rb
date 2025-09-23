class BooksController < ApplicationController
  before_action :authenticate_user, except: :index

  def index
    books = Book.includes(:author, :comments).order(created_at: :desc)
    render json: books
  end

  def create
    return render json: { error: "Only authors can create books" }, status: :forbidden unless @current_user&.author?
    book = @current_user.books.new(book_params)
    if book.save
      render json: book, status: :created
    else
      render json: { errors: book.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def my_books
    authenticate_user
    render json: @current_user.books
  end

  private


  def book_params
    params.require(:book).permit(:title, :description, :content, :published_at)
  end
end
