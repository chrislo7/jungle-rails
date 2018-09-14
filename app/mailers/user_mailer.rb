class UserMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def confirmation(order)
    @order = order
    @user = order.user
    @url = "http://0.0.0.0:3000/order/#{order.id}"
    mail(to: @user.email, subject: '#{order.id} has been confirmed')
  end

end
