require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @user = users(:test_user1)
    @post = @user.posts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content = "  "
    assert_not @post.valid?
  end

  test "content should be at most 500 characters" do
    @post.content = "a" * 301
    assert_not @post.valid?
  end

  test "post order should be most recent one is first" do
    assert_equal posts(:most_recent), Post.first
  end
end
