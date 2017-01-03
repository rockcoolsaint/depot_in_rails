require 'test_helper'

class StoresControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', minimum: 3
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /[N\$][,\d]+\.\d\d/
  end

end
