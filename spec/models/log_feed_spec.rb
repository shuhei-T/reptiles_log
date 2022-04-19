require 'rails_helper'

RSpec.describe LogFeed, type: :model do
  it 'is valid with all attributes' do
    log_feed = build(:log_feed)
      expect(log_feed).to be_valid
      expect(log_feed.errors).to be_empty
  end

  it 'is invalid count over status' do
    log_feed_count_over_status = build(:log_feed, count: '11')
    expect(log_feed_count_over_status).to be_invalid
    expect(log_feed_count_over_status.errors[:count]).to eq ["は10より小さい値にしてください"]
  end
end
