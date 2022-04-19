require 'rails_helper'

RSpec.describe Log, type: :model do
  it 'is valid with all attributes' do
    log = build(:log)
      expect(log).to be_valid
      expect(log.errors).to be_empty
  end

  it 'is invalid without logged_at' do
    log_without_logged_at = build(:log, logged_at: '')
    expect(log_without_logged_at).to be_invalid
    expect(log_without_logged_at.errors[:logged_at]).to eq ["を入力してください"]
  end

  it 'is invalid weight over status' do
    log_weight_over_status = build(:log, weight: '200000')
    expect(log_weight_over_status).to be_invalid
    expect(log_weight_over_status.errors[:weight]).to eq ["は100000より小さい値にしてください"]
  end

  it 'is invalid length over status' do
    log_length_over_status = build(:log, length: '200000')
    expect(log_length_over_status).to be_invalid
    expect(log_length_over_status.errors[:length]).to eq ["は100000より小さい値にしてください"]
  end

  it 'is invalid temperature over status' do
    log_temperature_over_status = build(:log, temperature: '70')
    expect(log_temperature_over_status).to be_invalid
    expect(log_temperature_over_status.errors[:temperature]).to eq ["は50より小さい値にしてください"]
  end

  it 'is invalid humidity over status' do
    log_humidity_over_status = build(:log, humidity: '200')
    expect(log_humidity_over_status).to be_invalid
    expect(log_humidity_over_status.errors[:humidity]).to eq ["は100より小さい値にしてください"]
  end
end
