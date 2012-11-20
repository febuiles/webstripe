class NotificationsMailer < ActionMailer::Base
  default from: "info@webstripe.co"

  def new_stripe(stripe)
    @stripe = stripe
    @user = stripe.user
    mail(subject: "Nuevo Stripe", to: "info@webstripe.co")
  end
end
