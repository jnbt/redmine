Redmine::Plugin.register :more_view_hooks do
  name "More View Hooks"
  author "Jonas Thiel"
  author_url "http://www.neopoly.de"
  description "Adds more view hooks into the Redmine templates"
  version "0.0.2"

  ActionDispatch::Callbacks.to_prepare do
    require "more_view_hooks"
  end
end

RedmineApp::Application.config.after_initialize do
  MoreViewHooks::InjectHooks.apply!
end
