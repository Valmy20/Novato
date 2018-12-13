namespace :seed do
  desc 'Admin'
  task admin: :environment do
    admin = Admin.new(
      name: 'Administrador',
      email: 'admin@localhost.com',
      password: '123456',
      password_confirmation: '123456',
      status: true
    )
    if admin.save
      p admin.email
    else
      build_errors(admin)
    end
  end

  desc 'Category'
  task category: :environment do
    5.times do
      category = Category.new(
        name: Faker::Space.planet,
        admin_id: Admin.last.id
      )
      if category.save
        p category.name
      else
        build_errors(category)
      end
    end
  end

  # desc 'User'
  # task user: :environment do
  #   1.times do
  #     user = User.new(
  #       name: Faker::Name.name,
  #       provider: 'User Provider',
  #       password: '123456',
  #       password_confirmation: '123456',
  #       email: 'user@default.com',
  #       status: [0, 1, 2].sample
  #     )
  #     if user.save
  #       p user.email
  #     else
  #       build_errors(user)
  #     end
  #   end
  #
  # end


  private

  def build_errors(obj)
    p obj.errors.each { |attr, err| p "#{attr} - #{err}" }
  end

end
