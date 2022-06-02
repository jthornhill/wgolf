require "test_helper"

class ResultSubmissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @result_submission = result_submissions(:one)
  end

  test "should get index" do
    get result_submissions_url
    assert_response :success
  end

  test "should get new" do
    get new_result_submission_url
    assert_response :success
  end

  test "should create result_submission" do
    assert_difference("ResultSubmission.count") do
      post result_submissions_url, params: { result_submission: { share_text: @result_submission.share_text, user_id: @result_submission.user_id, wordle_id: @result_submission.wordle_id } }
    end

    assert_redirected_to result_submission_url(ResultSubmission.last)
  end

  test "should show result_submission" do
    get result_submission_url(@result_submission)
    assert_response :success
  end

  test "should get edit" do
    get edit_result_submission_url(@result_submission)
    assert_response :success
  end

  test "should update result_submission" do
    patch result_submission_url(@result_submission), params: { result_submission: { share_text: @result_submission.share_text, user_id: @result_submission.user_id, wordle_id: @result_submission.wordle_id } }
    assert_redirected_to result_submission_url(@result_submission)
  end

  test "should destroy result_submission" do
    assert_difference("ResultSubmission.count", -1) do
      delete result_submission_url(@result_submission)
    end

    assert_redirected_to result_submissions_url
  end
end
