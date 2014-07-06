require 'test_helper'

class ListPairControllerTest < ActionController::TestCase
  test "should get align" do
    get :align
    assert_response :success
  end

end
