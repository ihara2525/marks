require 'test_helper'

class MarksTest < ActiveSupport::TestCase
  setup do
    @user = User.create!
    @reply = Reply.create!
  end

  test '#marks' do
    assert !@user.marks?(@reply, :nice)
    assert_raise(ArgumentError) { @user.marks?(@reply, :unknown_mark) }
    @user.marks(@reply, :nice)
    assert @user.marks?(@reply, :nice)
  end

  test '#markers' do
    assert @reply.markers(:user, :nice).empty?
    3.times { @user.marks(@reply, :nice) }
    assert_equal [@user, @user, @user], @reply.markers(:user, :nice)
    assert_raise(ArgumentError) { @reply.markers(:user, :unknown_mark) }
  end

  test '#unmarks' do
    3.times { @user.marks(@reply, :nice) }
    @user.unmarks(@reply, :nice)
    assert !@user.marks?(@reply, :nice)
  end
end
