class Book < ApplicationRecord
  include Filterable

  belongs_to :category, optional: true
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :mark_books
  has_many :order_detail
  has_many :favorites
  has_many :author_books, dependent: :destroy
  has_many :authors, through: :author_books

  accepts_nested_attributes_for :author_books

  validates :name, presence: true
  validates :description, presence: true
  validates :image, presence: true
  validates :publish_date, presence: true
  validates :price, presence: true
  validates :category_id, presence: true

  scope :order_by, ->{order created_at: :desc}
  scope :read_by, ->user{joins(:mark_books).where("mark_books.user_id = ? AND
    mark_books.status = ?", user.id,
    MarkBook.statuses[:reading]).order created_at: :desc}
  scope :favored_by, ->user{joins(:favorites).where("favorites.user_id = ?",
    user.id).order created_at: :desc}
  scope :like_max, (lambda do
    joins(:likes).select(:id, :image, :name, :price, "count(books.id) as like_num")
      .group(:id).order("count(books.id) desc").limit(4)
  end)
  scope :reading_max, (lambda do |status|
    joins(:mark_books).select(:id, :image, :name, :price, "count(books.id) as reading")
      .where("mark_books.status": status).group(:book_id).order("count(books.id) desc").limit(4)
  end)
  scope :author_book_by, ->author{joins(:author_books)
    .where("author_books.author_id = ?", author.id).order created_at: :desc}

  ratyrate_rateable "rating"
  mount_uploader :image, ImageUploader
end
