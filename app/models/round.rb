class Round < ApplicationRecord
  belongs_to :wordle
  has_many :rounds_users
  has_many :users, through: :rounds_users
  has_many :result_submissions, through: :users

  def wordle_num=(wordle_num)
    self.wordle = Wordle.find_or_initialize_by(game_number: wordle_num)
  end

  def final_wordle
    @final_wordle ||= Wordle.for_game_num(wordle.game_number + 17)
  end

  def finished?
    aoe_date = Time.current.in_time_zone('International Date Line West').to_date
    final_wordle.date < aoe_date
  end

  def reversed_result_for_user_id_by_idx(user_id, idx)
    reversed_results_by_user_id if @reversed_result_grid_by_user_id.blank?
    @reversed_result_grid_by_user_id[user_id][idx]
  end

  def reversed_results_by_user_id
    return @reversed_results_by_user_id if @reversed_results_by_user_id.present?

    @reversed_result_grid_by_user_id = {}
    @reversed_results_by_user_id = {}
    unsorted_reversed_results = {}
    wordle_ids = wordles.map(&:id)
    submissions = result_submissions.where(wordle_id: wordle_ids).to_a

    users.each do |u|
      subs = submissions.select { |s| s.user_id == u.id }
      unsorted_reversed_results[u.id] = []
      @reversed_result_grid_by_user_id[u.id] = []
      total = 0
      over_under = 0
      reversed_wordles.each do |w|
        sub = subs.find { |s| s.wordle_id == w.id }
        @reversed_result_grid_by_user_id[u.id] << sub
        if sub.nil? || sub.score.blank?
          unsorted_reversed_results[u.id] << nil
          total += 7
          # penalize them with a +3 if we are past aoe_today
          over_under += 3 if w.finished?
          next
        end
        unsorted_reversed_results[u.id] << sub.score
        total += sub.score
        over_under = over_under + sub.score - 4
      end
      unsorted_reversed_results[u.id] << over_under
      unsorted_reversed_results[u.id] << total
    end
    @reversed_results_by_user_id = Hash[unsorted_reversed_results.sort_by { |_k, v| v[-2] }]
  end

  def result_for_user_id_by_idx(user_id, idx)
    results_by_user_id if @result_grid_by_user_id.blank?
    @result_grid_by_user_id[user_id][idx]
  end

  def results_by_user_id
    return @results_by_user_id if @results_by_user_id.present?

    @result_grid_by_user_id = {}
    @results_by_user_id = {}
    unsorted_results = {}
    wordle_ids = wordles.map(&:id)
    submissions = result_submissions.where(wordle_id: wordle_ids).to_a

    users.each do |u|
      subs = submissions.select { |s| s.user_id == u.id }
      unsorted_results[u.id] = []
      @result_grid_by_user_id[u.id] = []
      total = 0
      over_under = 0
      wordles.each do |w|
        sub = subs.find { |s| s.wordle_id == w.id }
        @result_grid_by_user_id[u.id] << sub
        if sub.nil? || sub.score.blank?
          unsorted_results[u.id] << nil
          total += 7
          next
        end
        unsorted_results[u.id] << sub.score
        total += sub.score
        over_under = over_under + sub.score - 4
      end
      unsorted_results[u.id] << over_under
      unsorted_results[u.id] << total
    end
    @results_by_user_id = Hash[unsorted_results.sort_by { |_k, v| v[-2] }]
  end

  def results_for(user)
    wordles.map do |w|
      w.result_submissions.find_by(user_id: user.id)
    end
  end

  def wordle_num
    wordle&.game_number
  end

  def reversed_wordles
    @reversed_wordles ||= wordles.reverse
  end

  def wordles
    return [] if wordle.nil?
    return @wordles if @wordles.present?

    @wordles = [wordle]
    17.times do |t|
      word = Wordle.for_game_num(wordle.game_number + t + 1)
      break if word.date > Date.current

      @wordles << word
    end
    @wordles
  end

  def to_s
    wordle&.to_s.presence || super
  end
end
