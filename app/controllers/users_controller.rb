class UsersController < ApplicationController
  before_action :authenticate_user! , except: [:show]
  before_action :set_user, only: [:show_profile]

  require "date"

  def index
    list = current_user.lists
    each_status(list)
    @readed = current_user.reviews.order("created_at DESC")
    @page = page(current_user.reviews)
    @count_page = count_page(@page)
    @this_month_count = current_user.reviews.includes(:review).where(created_at: Time.now.all_month).count
  end

  def review
    @readed = current_user.reviews.order("updated_at DESC")
  end

  def show_profile
    each_status(@user.lists)
    @page = page(@user.reviews)
    @count_page = count_page(@page)
    @this_month_count = @user.reviews.includes(:review).where(created_at: Time.now.all_month).count

    @users_review = @user.reviews.where(user_id: params[:id])
    @users_list = @user.lists.where(user_id: params[:id])
    
    if @users_review.present? || @users_list.present?
      array = []
      array += @users_review if @users_review.present?
      array += @users_list if @users_list.present?
      @result = array.sort {|a, b| b[:updated_at] <=> a[:updated_at]}
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to mypage_index_path, notice: "ユーザー情報を変更しました"
    else
      redirect_to mypage_index_path, alert: "ユーザー情報を変更できません"
    end
  end

  protected

  def page(current)
    sum = 0
    current.each do |rev|
      sum += rev.book.page
    end
    return sum
  end

  def each_status(status)
    @status_first = status.where(status: 0).order("created_at DESC")
    @status_second = status.where(status: 1).order("created_at DESC")
    @status_third = status.where(status: 2).order("created_at DESC")
  end

  def count_page(page)
    now_day = Date.today
    createdDateTime = current_user.created_at.strftime('%Y/%m/%d')
    createdDate = Date.parse(createdDateTime)
    elapsed_day = now_day - createdDate

    elapsed_day = 1 if elapsed_day < 1
    count_page = page / elapsed_day.to_s.split("/")[0].to_i
    return count_page
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :sex, :birthday, :image, :introduction, :area)
  end
end
