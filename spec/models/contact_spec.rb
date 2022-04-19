require 'rails_helper'

RSpec.describe Contact, type: :model do
  it 'is valid with all attributes' do
    contact = build(:contact)
    expect(contact).to be_valid
    expect(contact.errors).to be_empty
  end

  it 'is invalid without name' do
    contact_without_name = build(:contact, name: '')
    expect(contact_without_name).to be_invalid
    expect(contact_without_name.errors[:name]).to eq ["を入力してください"]
  end

  it 'is invalid without email' do
    contact_without_email = build(:contact, email: '')
    expect(contact_without_email).to be_invalid
    expect(contact_without_email.errors[:email]).to eq ["を入力してください"]
  end

  it 'is invalid with contrary to email' do
    contact_with_contrary_to_email1 = build(:contact, email:'testemailexample.com')
    contact_with_contrary_to_email2 = build(:contact, email:'testemailexamplecom')
    contact_with_contrary_to_email3 = build(:contact, email:'testemail@examplecom')
    contact_with_contrary_to_email4 = build(:contact, email:'testemail@example.123')
    contact_with_contrary_to_email5 = build(:contact, email:'testemail@.com')
    expect(Contact.all.count).to eq 0
  end

  it 'is invalid without message' do
    contact_without_message = build(:contact, message: '')
    expect(contact_without_message).to be_invalid
    expect(contact_without_message.errors[:message]).to eq ["を入力してください"]
  end
end
