class Book < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :people_num, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1}
  validates :check_in, :check_out, presence: true
  validate :start_end_check
  validate :same_day_check
  validate :before_start_check

  def start_end_check
    if self.check_in.present? && self.check_out.present?
      if self.check_in > self.check_out
        errors.add(:check_out, "はチェックインより前の日付で登録できません")
      end
    end
  end

  def same_day_check
    if self.check_in.present? && self.check_out.present?
      if Book.where('(check_out > ? and ? > check_in) and (room_id = ?)', self.check_in, self.check_out, self.room_id).any?
        errors.add(:check_in, 'はこの期間に予約はできません。')
      end
    end
  end

  def before_start_check
    if self.check_in.present?
      if self.check_in < Date.today
        errors.add(:check_in, "は今日以降のものを選択してください")
      end
    end
  end
end
