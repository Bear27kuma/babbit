require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:test_user1)
    @non_admin = users(:test_user2)
  end

  test "users index including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    first_page_of_users = User.where(activated: true).paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      assert_match user.email, response.body
      assert_match user.login_at.strftime('%Y/%m/%d %H:%M:%S'), response.body
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'このユーザーを削除'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "users index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
