class AddScoreToResultSubmission < ActiveRecord::Migration[7.0]
  def change
    add_column :result_submissions, :score, :integer
  end
end
