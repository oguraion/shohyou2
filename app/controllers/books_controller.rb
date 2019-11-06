class BooksController < ApplicationController
  before_action :set_book , only: [:edit, :update]

  def index
    sort = params[:sort] || "2"
    case sort
    when "1" then
      result = "created_at ASC"
    when "2" then
      result = "created_at DESC"
    when "3" then
      result = "page ASC"
    when "4" then
      result = "page DESC"
    end
    @books = Book.order(result)
    
    # 絞込み検索機能
    @search = params[:search]
    if @search.present?
      @books = Book.order(result)
      @search.split(/[[:blank:]]+/).each do |keyword|
        next if keyword == ""
        @books = @books.where('name LIKE(?) OR author LIKE(?)', "%#{keyword}%", "%#{keyword}%")
      end
    end
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to books_path, notice: "本を登録しました"
    else
      render :new, alert: "本を登録できませんでした"
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      redirect_to show_books_path(@book.id), notice: "本を情報を編集しました"
    else
      render :edit, alert: "本の情報を編集できませんでした"
    end
  end

  def show
    @book = Book.find(params[:book_id])
    @list_new = @book.lists.new
    @lists = List.find_by(user_id: current_user.id, book_id: @book.id)
    @review = @book.reviews.order("created_at DESC")

    registration_review = @book.reviews
    registration_list = @book.lists
    registration = []
    registration += registration_review if registration_review.present?
    registration += registration_list if registration_list.present?
    @reg = []
    registration.each do |regist|
      if @reg.include?(regist.user) == false && regist.user != nil
        @reg << regist.user
      end
    end
  end


  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :author, :page, :image, :discription)
  end
end
