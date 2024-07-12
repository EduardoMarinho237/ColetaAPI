require "test_helper"

class VisitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @visit = visits(:one)
  end

  test "should get index" do
    get visits_url, as: :json
    assert_response :success
  end

  test "should create visit" do
    assert_difference("Visit.count") do
      post visits_url, params: { visit: { checkin_at: @visit.checkin_at, checkout_at: @visit.checkout_at, date: @visit.date, status: @visit.status, user_id: @visit.user_id } }, as: :json
    end

    assert_response :created
  end

  test "should show visit" do
    get visit_url(@visit), as: :json
    assert_response :success
  end

  test "should update visit" do
    patch visit_url(@visit), params: { visit: { checkin_at: @visit.checkin_at, checkout_at: @visit.checkout_at, date: @visit.date, status: @visit.status, user_id: @visit.user_id } }, as: :json
    assert_response :success
  end

  test "should destroy visit" do
    assert_difference("Visit.count", -1) do
      delete visit_url(@visit), as: :json
    end

    assert_response :no_content
  end
end
