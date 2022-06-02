json.extract! result_submission, :id, :user_id, :wordle_id, :share_text, :created_at, :updated_at
json.url result_submission_url(result_submission, format: :json)
