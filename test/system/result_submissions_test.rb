require "application_system_test_case"

class ResultSubmissionsTest < ApplicationSystemTestCase
  setup do
    @result_submission = result_submissions(:one)
  end

  test "visiting the index" do
    visit result_submissions_url
    assert_selector "h1", text: "Result submissions"
  end

  test "should create result submission" do
    visit result_submissions_url
    click_on "New result submission"

    fill_in "Share text", with: @result_submission.share_text
    fill_in "User", with: @result_submission.user_id
    fill_in "Wordle", with: @result_submission.wordle_id
    click_on "Create Result submission"

    assert_text "Result submission was successfully created"
    click_on "Back"
  end

  test "should update Result submission" do
    visit result_submission_url(@result_submission)
    click_on "Edit this result submission", match: :first

    fill_in "Share text", with: @result_submission.share_text
    fill_in "User", with: @result_submission.user_id
    fill_in "Wordle", with: @result_submission.wordle_id
    click_on "Update Result submission"

    assert_text "Result submission was successfully updated"
    click_on "Back"
  end

  test "should destroy Result submission" do
    visit result_submission_url(@result_submission)
    click_on "Destroy this result submission", match: :first

    assert_text "Result submission was successfully destroyed"
  end
end
