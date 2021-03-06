class Book < ApplicationRecord
  has_many :user_books, dependent: :destroy
  has_many :book_categories, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :users, through: :user_books
  has_many :categories, through: :book_categories
  mount_uploader :image, ImageUploader

  validates :title, presence: {accept: true, message: "không được để trống"}
  validates :author, presence: {accept: true, message: "không được để trống"}
  validates :number_of_pages, numericality: {greater_than: 0, only_integer: true, message: "phải là một số nguyên dương"}
  validates :publish_date, presence: {accept: true, message: "không được để trống"}
  validates :summary, presence: {accept: true, message: "không được để trống"}

  scope :cat_books, ->(cat_id) do
    joins(:book_categories).where("category_id = #{cat_id}").order("title")
  end
  scope :alpha, ->{order title: :desc}
  scope :newest, ->{order created_at: :desc}
  scope :search_for_title, ->(text) do
    where("title LIKE BINARY ?", "%#{text}%") if text.present?
  end
  scope :search_for_author, ->(text) do
    where("author LIKE BINARY ?", "%#{text}%") if text.present?
  end

  def self.search text_search, search_for
    if search_for == I18n.t(".submit_author")
      Book.search_for_author text_search
    else
      Book.search_for_title text_search
    end
  end
end
