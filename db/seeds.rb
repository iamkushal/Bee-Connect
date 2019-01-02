['registered', 'banned', 'moderator', 'admin','group_approved','group_pending_approval'].each do |role|
  Role.find_or_create_by({name: role})
end

admin_user = {email:  'admin@gmail.com',
              password:  'admin123',
              password_confirmation: 'admin123',
              first_name: "Admin",
              last_name:  "Power",
              user_name:  "Admin",
              bio: "Admin is the super user",
              is_female: false,
              :confirmed_at => DateTime.now
            }
a  = Role.where(name: 'admin').first.users.build(admin_user)
#a.skip_confirmation!
a.save!
