class ReviewsController < ApplicationController
  before_action :set_book, except: :destroy

  def new
    @review = @book.reviews.new
  end

  def create
    @list = List.find_by(user_id: current_user, book_id: @book.id)
    @review = @book.reviews.new(review_params)
    if @review.save
      @list.destroy if @list.present?
      redirect_to show_books_path(set_book), notice: "「読んだ本リスト」へ登録できました"
    else
      render :new, alert: "「読んだ本リスト」へ登録できませんでした"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    if @review.user_id == current_user.id
      @review.destroy
      redirect_to show_books_path(@review.book.id), notice: "レビューを削除しました"
    else
      redirect_to show_books_path(@review.book.id), alert: "レビューを削除できません"
    end
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def review_params
    params.require(:review).permit(:day, :comment).merge(user_id: current_user.id, book_id: @book.id)
  end
end
