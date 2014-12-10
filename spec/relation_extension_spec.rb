require 'spec_helper'

describe 'Marks::RelationExtension' do
  let(:user) { User.create! }
  let(:type) { :nice }
  let(:marked_reply) { Reply.create! }
  let(:not_marked_reply) { Reply.create! }

  before do
    user.marks(marked_reply, type)
  end

  describe '#preload_marker' do
    let(:relation) { Reply.where(id: marked_reply.id).preload_marker(user, type) }

    it 'sets marker_value and mark_type_values to relation' do
      relation.marker_value.must_equal user
      relation.mark_type_values.must_equal [type]
    end

    it 'does not change marked_by? result' do
      expected = Reply.where(id: [marked_reply.id, not_marked_reply.id]).
        map { |reply| reply.marked_by?(user, type) }
      actual = Reply.where(id: [marked_reply.id, not_marked_reply.id]).
        preload_marker(user, type).
        map { |reply| reply.marked_by?(user, type) }

      expected.must_equal actual
    end
  end
end
