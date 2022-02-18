# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  def contact_mail
    contact = Contact.new(name: "sample 太郎", email: "sample@example.com", message: "お問い合わせメッセージ")
    ContactMailer.contact_mail(contact)
  end
end
