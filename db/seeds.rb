# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def users_seed(size = 30)
  admin = User.new(
    email: "hyekyoz@outlook.com",
    password: "password123"
  )
  admin.skip_confirmation!
  admin.save
  admin.add_role :admin

  merchant = User.new(
    email: "799654910@qq.com",
    password: "password123"
  )
  merchant.skip_confirmation!
  merchant.save
  merchant.add_role :merchant

  size.times do |index|
    created_time = Time.now - (rand(1..1000)).day
    user = User.new(
      email: "#{Faker::Name.unique.first_name}@jforder.com",
      password: "password123",
      created_at: created_time,
      updated_at: created_time
    )
    user.skip_confirmation!
    user.save
    user.add_role :merchant
  end
end

def random_picture
  pictures_url = ENV['CODE_PICTURES']
  entries = Dir.new(pictures_url).entries
  entries.delete_if { |entry| entry =~ /^\./ }
  "#{pictures_url}/#{entries.sample}"
end

def locations_seed()
  locations = %w(第一食堂 第二食堂 第三食堂 第四食堂)
  locations.each do |location|
    Location.create! name: location
  end
end

# size 是每个用户的商铺数量
def stores_seed(size = 2)
  User.all.each do |user|
    size.times { user.stores.create name: Faker::Company.name,
                                    intro: Faker::Address.street_address,
                                    location_id: Location.ids.sample }
  end

  Store.all.each do |store|
    File.open(random_picture) do |f|
      store.create_picture picture: f
    end
  end
end

# size 是每个商铺的菜品数量
def menus_seed(size = 6)
  User.all.each do |user|
    unless user.id == 1
      user.stores.each do |store|
        3.times { store.menus.create name: Faker::Food.dish,
                                     intro: Faker::Lorem.sentence,
                                     publish: true,
                                     price: rand(1..8) }
      end
    end
  end

  Menu.all.each do |menu|
    File.open(random_picture) do |f|
      3.times { menu.pictures.create picture: f }
    end
  end
end

users_seed
locations_seed
stores_seed
menus_seed
