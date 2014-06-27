Redmine::Plugin.register :project_custom_style do
  name "Project Custom Style"
  author "Jonas Thiel"
  author_url "http://www.neopoly.de"
  description "Allows additional CSS / JS styling via a " \
              "special wiki page 'CustomStyle'."
  version "0.0.1"

  requires_redmine_plugin "more_view_hooks", version_or_higher: "0.0.1"

  ActionDispatch::Callbacks.to_prepare do
    require "project_custom_style_hooks"
  end
end
