class ResultSubmission < ApplicationRecord
  belongs_to :user
  belongs_to :wordle
  before_save :set_score, if: -> { share_text_changed? }
  before_validation :find_wordle
  validate :not_yet_submitted
  validate :found_wordle

  def wordle_num
    return nil if share_text.blank?

    match = share_text.match(/.*Wordle ([0-9]+)/)
    return nil if match.blank?

    match[1]
  end

  def find_wordle
    self.wordle = Wordle.find_or_initialize_by(game_number: wordle_num)
  end

  def set_score
    match = share_text.match(%r{.*Wordle [0-9]+ (.)/6})
    return if match.blank?

    self.score = if match[1].downcase == 'x'
                   7
                 else
                   match[1]
                 end
  end

  def found_wordle
    return if wordle_num.present? && wordle.present?

    errors.add(:share_text, "The text you pasted doesn't look right, try again")
  end

  def not_yet_submitted
    return unless ResultSubmission.find_by(wordle_id:, user_id:).present?

    errors.add(:share_text, "Wordle #{wordle.game_number} was already submitted")
  end
end
