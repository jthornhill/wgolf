require "application_system_test_case"

class PreferencesTest < ApplicationSystemTestCase
  setup do
    @preference = preferences(:one)
  end

  test "visiting the index" do
    visit preferences_url
    assert_selector "h1", text: "Preferences"
  end

  test "should create preference" do
    visit preferences_url
    click_on "New preference"

    fill_in "Time zone", with: @preference.time_zone
    fill_in "User", with: @preference.user_id
    click_on "Create Preference"

    assert_text "Preference was successfully created"
    click_on "Back"
  end

  test "should update Preference" do
    visit preference_url(@preference)
    click_on "Edit this preference", match: :first

    fill_in "Time zone", with: @preference.time_zone
    fill_in "User", with: @preference.user_id
    click_on "Update Preference"

    assert_text "Preference was successfully updated"
    click_on "Back"
  end

  test "should destroy Preference" do
    visit preference_url(@preference)
    click_on "Destroy this preference", match: :first

    assert_text "Preference was successfully destroyed"
  end
end
