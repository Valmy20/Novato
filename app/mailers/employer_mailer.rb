class EmployerMailer < ApplicationMailer
  default from: 'novatoirece@gmail.com'
  layout 'mailer'

  def confirm_email(user)
    @user = user
    mail(to: @user.email, subject: 'Confirmação de email: Novato Irecê')
  end

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
