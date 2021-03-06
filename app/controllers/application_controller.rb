class ApplicationController < ActionController::Base
  include LoginsHelper
  protect_from_forgery with: :exception

  def collection_paginate collection, page, per_page
    collection.paginate page: page, per_page: per_page
  end

  def book_star book
    if book.reviews.blank?
      @average = 0
      @count_rate = 0
    else
      @average = book.reviews.average(:rate).round 2
      @count_rate = book.reviews.count
    end
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = "Xin vui lòng đăng nhập tài khoản"
    redirect_to login_url
  end
end
