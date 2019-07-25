class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  scope :search, lambda { |page, term|
    includes(:answers)
      .where('lower(description) LIKE ?', "%#{term.downcase}%")
      .page(page)
      .per(10)
  }

  scope :last_questions, lambda { |page|
    includes(:answers)
      .order('created_at desc')
      .page(page).per(5)
  }
end
