namespace :seed do
  desc 'Admin'
  task admin: :environment do
    admin = Admin.new(
      name: 'Administrador Geral',
      email: 'admin@novato.com',
      password: '123456',
      password_confirmation: '123456',
      status: true,
      rules: :full_access
    )
    if admin.save
      p admin.email
    else
      build_errors(admin)
    end
  end

  desc 'User'
  task user: :environment do
    1.times do
      avatar_url = Faker::LoremFlickr.image("200x200")
      cover_url = Faker::LoremFlickr.image("600x160")
      user = User.new(
        name: Faker::Name.name,
        password: '123456',
        password_confirmation: '123456',
        email: Faker::Internet.email,
        phone: Faker::PhoneNumber.cell_phone,
        status: 1,
        remote_avatar_url: avatar_url,
        remote_cover_url: cover_url
      )
      if user.save
        p user.email
      else
        build_errors(user)
      end

      extra = UserExtra.new
      extra.bio = Faker::Lorem.paragraph_by_chars([100, 160, 247].sample, false),
      extra.user_id = user.id

      if extra.save
        puts "User extra id: #{extra.user_id} saved"
      else
        build_errors(extra)
      end

      rand = [6, 4].sample
      rand.times do
        skill = Skill.new(
          name: Faker::Music.band,
          user_id: user.id
        )
        if skill.save
          p skill.name
        else
          build_errors(skill)
        end
      end
    end
    User.find_each(&:save)
  end

  desc 'Employer'
  task employer: :environment do
    1.times do
      logo_url = Faker::LoremFlickr.image("200x200")
      employer = Employer.new(
        name: Faker::Company.name,
        email: Faker::Internet.email,
        password: '123456',
        password_confirmation: '123456',
        remote_logo_url: logo_url,
        status: 1,
      )
      if employer.save
        p employer.name
      else
        build_errors(employer)
      end

      extra = EmployerExtra.new
      extra.about = Faker::Lorem.paragraph_by_chars([100, 160, 247].sample, false),
      extra.phone = Faker::PhoneNumber.cell_phone,
      extra.employer_id = employer.id

      if extra.save
        puts "Employer extra saved"
      else
        build_errors(extra)
      end
    end
    Employer.find_each(&:save)
  end

  desc 'Institution'
  task institution: :environment do
    1.times do
      logo_url = Faker::LoremFlickr.image("200x200")
      institution = Institution.new(
        name: Faker::Educator.university,
        email: Faker::Internet.email,
        password: '123456',
        password_confirmation: '123456',
        remote_logo_url: logo_url,
        status: 1,
      )
      if institution.save
        p institution.name
      else
        build_errors(institution)
      end

      extra = InstitutionExtra.new
      extra.about = Faker::Lorem.paragraph_by_chars([100, 160, 247, 400].sample, false),
      extra.phone = Faker::PhoneNumber.cell_phone,
      extra.location = "-11.33454, -42.13392",
      extra.institution_id = institution.id

      if extra.save
        puts "Institution extra saved"
      else
        build_errors(extra)
      end
    end
    Institution.find_each(&:save)
  end

  desc 'Collaborator'
  task collaborator: :environment do
    collaborator = Collaborator.new(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: '123456',
      password_confirmation: '123456'
    )
    if collaborator.save
      p collaborator.email
    else
      build_errors(collaborator)
    end
    Collaborator.find_each(&:save)
  end

  desc 'Category'
  task category: :environment do
    2.times do
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
    Category.find_each(&:save)
  end

  desc 'Posts'
  task post: :environment do
    thumb_url = Faker::LoremFlickr.image("300x220")
    1.times do
      post = Post.new(
        title: Faker::Lorem.sentence,
        remote_thumb_url: thumb_url,
        body: Faker::Lorem.paragraph_by_chars([6230, 2500, 3500, 5000].sample, false),
        postable_type: "Collaborator",
        postable_id: Collaborator.last.id
      )
      if post.save
        p post.title
      else
        build_errors(post)
      end

      ass_category = AssPostCategory.new
      ass_category.post_id = post.id
      ass_category.category_id = Category.all.sample.id

      if ass_category.save
        p "Category saved"
      else
        build_errors(ass_category)
      end
    end
  end

  desc 'Publications'
  task publication: :environment do
    1.times do
      publciation = Publication.new(
        title: Faker::Job.title,
        _type: [0, 1].sample,
        information: Faker::Lorem.paragraph_by_chars([200, 260, 447, 600].sample, false),
        remunaration: [200, 400, 450, 1000, 2500, 3000].sample,
        vacancies: [1, 2, 3].sample,
        location: ["-11.33454, -42.13392", nil].sample,
        publicationable_type: "Employer",
        publicationable_id: Employer.all.sample.id
      )
      if publciation.save
        p publciation.title
      else
        build_errors(publciation)
      end
    end
  end

  private

  def build_errors(obj)
    p obj.errors.each { |attr, err| p "#{attr} - #{err}" }
  end

end
