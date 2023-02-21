require "application_system_test_case"

class ChangesTest < ApplicationSystemTestCase
  setup do
    @change = changes(:one)
  end

  test "visiting the index" do
    visit changes_url
    assert_selector "h1", text: "Changes"
  end

  test "should create change" do
    visit changes_url
    click_on "New change"

    fill_in "Comment", with: @change.comment_id
    fill_in "From", with: @change.from
    fill_in "Project", with: @change.project_id
    fill_in "To", with: @change.to
    fill_in "User", with: @change.user_id
    click_on "Create Change"

    assert_text "Change was successfully created"
    click_on "Back"
  end

  test "should update Change" do
    visit change_url(@change)
    click_on "Edit this change", match: :first

    fill_in "Comment", with: @change.comment_id
    fill_in "From", with: @change.from
    fill_in "Project", with: @change.project_id
    fill_in "To", with: @change.to
    fill_in "User", with: @change.user_id
    click_on "Update Change"

    assert_text "Change was successfully updated"
    click_on "Back"
  end

  test "should destroy Change" do
    visit change_url(@change)
    click_on "Destroy this change", match: :first

    assert_text "Change was successfully destroyed"
  end
end
