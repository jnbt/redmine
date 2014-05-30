module WikiExtensionsTwitterMacro
  Redmine::WikiFormatting::Macros.register do
    desc "Creates link to a user page including an avatar.<pre>" \
         "{{user(the_user_login)}}\n" \
         "{{user(the_user_login, size=small)}}\n" \
         "</pre>"
    macro :user do |_obj, args|
      args, options = extract_macro_options(args, :size)
      return nil unless args.first.present?
      username = args.first.strip
      user     = User.find_by_login(username)
      return nil unless user

      user_wiki_macro_link(user, options)
    end
  end
end
