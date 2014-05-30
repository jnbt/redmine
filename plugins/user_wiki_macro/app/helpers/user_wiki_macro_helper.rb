module UserWikiMacroHelper
  USER_SIZES = {
    small: 14,
    default: 24,
    large: 50
  }

  def user_wiki_macro_link(user, options = {})
    size = if options[:size]
             USER_SIZES[options[:size].to_sym] || options[:size]
           else
             USER_SIZES[:default]
           end

    content_tag :span, class: "neopoly-macro neopoly-macro-user" do
      label = avatar(user, size: size) + content_tag(:span, user.login)
      link_to label, user_path(user)
    end
  end
end
