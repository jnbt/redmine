Redmine::Plugin.register :user_wiki_macro do
  name "User wiki macro"
  author "Jonas Thiel"
  description "Add a {{user(login_name)}} macro to the wiki engine"
  version "0.0.1"
  url "http://www.neopoly.de"
  author_url "http://www.neopoly.de"
end

ActionDispatch::Callbacks.to_prepare do
  unless ActionView::Base.included_modules.include?(ActionView::Base)
    ActionView::Base.class_eval do
      include UserWikiMacroHelper
    end
  end

  require "user_wiki_macro"
  require "user_wiki_macro_application_hooks"
end
