class Wordle < ApplicationRecord
  has_many :rounds
  has_many :result_submissions

  def date
    return nil unless game_number.present?

    (Date.new(2021, 6, 19) + game_number.to_i.days)
  end

  # Use the last time on earth to determine if we should penalize a person for not
  # providing an answer
  def finished?
    date < Time.current.in_time_zone('International Date Line West').to_date
  end

  def to_s
    return "#{game_number} (#{date})" if game_number.present?

    super
  end

  def self.for_date(date)
    find_or_initialize_by(game_number: (date - Date.new(2021, 6, 19)).to_i)
  end

  def self.for_game_num(num)
    find_or_initialize_by(game_number: num)
  end
end
