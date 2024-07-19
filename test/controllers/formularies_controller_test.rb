require "test_helper"

class FormulariesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @formulary = formularies(:one)
  end

  test "should get index" do
    get formularies_url, as: :json
    assert_response :success
  end

  test "should create formulary" do
    assert_difference("Formulary.count") do
      post formularies_url, params: { formulary: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show formulary" do
    get formulary_url(@formulary), as: :json
    assert_response :success
  end

  test "should update formulary" do
    patch formulary_url(@formulary), params: { formulary: {  } }, as: :json
    assert_response :success
  end

  test "should destroy formulary" do
    assert_difference("Formulary.count", -1) do
      delete formulary_url(@formulary), as: :json
    end

    assert_response :no_content
  end
end
