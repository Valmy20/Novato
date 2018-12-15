class UserMailer < ApplicationMailer
  default from: 'novatoirece@gmail.com'
  layout 'mailer'

  def reset_password(user)
    @user = user
    mail(to: @user.email, subject: 'Resetar senha: Novato Irecê')
  end

  def send_new_password(user, password)
    @user = user
    @password = password
    mail(to: @user.email, subject: 'Senha atualizada !')
  end
end
