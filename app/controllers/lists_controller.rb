class ListsController < ApplicationController
  before_action :set_book , only: [:create, :update, :destroy]
  
  def show
    @list = User.find_by(id: current_user.id).lists.where(status: params[:lists_id]).order("updated_at DESC")
    @lists_number = params[:lists_id]
  end

  def create
    @list = @book.lists.new(list_params)
    if @list.save
      redirect_to show_books_path(@book), notice: "Myリストへ登録しました"
    else
      redirect_to show_books_path(@book), alert: "Myリストから登録できませんでした"
    end
  end

  def destroy
    @lists = List.find_by(user_id: current_user.id, book_id: @book.id)
    if @lists.user_id == current_user.id
      @lists.destroy
      redirect_to show_books_path(@book), notice: "Myリストから削除しました"
    else
      redirect_to show_books_path(@book), alert: "Myリストから削除できませんでした"

    end
  end

  def edit
    @lists = @book.lists.find_by(user_id: current_user)    
  end

  def update
    @lists = @book.lists.find_by(user_id: current_user, book_id: @book.id)
    if @lists.update(list_params)
      redirect_to show_books_path(@book), notice: "登録の状態を変更しました"
    else
      redirect_to show_books_path(@book), alert: "登録の状態を変更できませんでした"
    end

  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def list_params
    params.require(:list).permit(:status).merge(user_id: current_user.id, book_id: @book.id)
  end
end
