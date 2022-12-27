class Room < ApplicationRecord
  belongs_to :user
  has_many :books, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :introduction, presence: true, length: { maximum: 100 }

  def self.search(area, keyword)
    if keyword == nil
      keyword = ""
    end
    if area != "" && keyword != ""
      where(["name like? or address like? or introduction like?", "%#{keyword}%", "%#{area}%", "%#{keyword}%"])
    elsif area != ""
      where(["address like?", "%#{area}%"])
    elsif keyword != ""
      where(["name like? or introduction like?", "%#{keyword}%", "%#{keyword}%"])
    else
      []
    end
  end
end
