require 'spec_helper'

describe 'Marks' do
  let(:user) { User.create! }
  let(:reply) { Reply.create! }
  let(:type) { :nice }

  describe '#marks' do
    describe 'raising error' do
      it 'raises error if the mark type is unknown' do
        proc { user.marks(reply, :unknown_mark) }.must_raise ArgumentError
      end
    end

    it 'marks the target with the type' do
      mark = user.marks(reply, type)
      mark.must_be_instance_of Marks::Mark
    end

    it 'returns nil if unique option is passed and the target is marked already' do
      user.marks(reply, type)
      mark = user.marks(reply, type, unique: true)
      mark.must_equal nil
    end
  end

  describe '#marks?' do
    describe 'raising error' do
      it 'raises error if the mark type is unknown' do
        proc { user.marks?(reply, :unknown_mark) }.must_raise ArgumentError
      end
    end

    it 'returns true if the mark is marked with the type' do
      user.marks(reply, type)
      user.marks?(reply, type).must_equal true
    end

    it 'returns false if the mark is not marked yet' do
      user.marks?(reply, type).must_equal false
    end
  end

  describe '#unmarks' do
    describe 'raising error' do
      it 'raises error if the mark type is unknown' do
        proc { user.marks?(reply, :unknown_mark) }.must_raise ArgumentError
      end
    end

    before { 3.times { user.marks(reply, type) } }

    it 'unmarks the target with the type' do
      user.unmarks(reply, type)
      user.marks?(reply, type).must_equal false
    end
  end

  describe '#markings' do
    describe 'raising error' do
      it 'raises error if the mark type is unknown' do
        proc { user.markings(Reply, :unknown_mark) }.must_raise ArgumentError
      end
    end

    let(:another_reply) { Reply.create! }

    before do
      user.marks(reply, type)
      user.marks(another_reply, type)
    end

    it 'returns all targets with the type' do
      user.markings(Reply, type).map(&:markable_id).must_equal [reply.id, another_reply.id]
    end
  end

  describe '#markers' do
    describe 'raising error' do
      it 'raises error if the mark type is unknown' do
        proc { user.marks?(reply, :unknown_mark) }.must_raise ArgumentError
      end
    end

    let(:another_user) { User.create! }

    before do
      2.times { user.marks(reply, type) }
      another_user.marks(reply, type)
    end

    it 'returns markers of the mark with the type' do
      reply.markers(:user, type).must_equal [user, user, another_user]
    end
  end

  describe '#marked_by' do
    describe 'raising error' do
      it 'raises error if the mark type is unknown' do
        proc { user.marks?(reply, :unknown_mark) }.must_raise ArgumentError
      end
    end

    describe 'when the user marks the target with the type' do
      before { user.marks(reply, type) }

      it 'returns true' do
        reply.marked_by?(user, type).must_equal true
      end
    end

    describe 'when the user does not mark the target with the type' do
      it 'returns false' do
        reply.marked_by?(user, type).must_equal false
      end
    end

    describe 'when nil is passed as marker' do
      it 'returns false' do
        reply.marked_by?(nil, type).must_equal false
      end
    end
  end
end
