Redmine::Plugin.register :user_wiki_macro do
  name "User wiki macro"
  author "Jonas Thiel"
  description "Add a {{user(login_name)}} macro to the wiki engine"
  version "0.0.1"
  url "http://www.neopoly.de"
  author_url "http://www.neopoly.de"

  ActionDispatch::Callbacks.to_prepare do
    require "user_wiki_macro"
    require "user_wiki_macro_application_hooks"
  end
end

ApplicationHelper.class_eval do
  include UserWikiMacroHelper
end