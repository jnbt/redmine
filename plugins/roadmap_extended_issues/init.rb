Redmine::Plugin.register :roadmap_extended_issues do
  name "Roadmap Extended Issues"
  author "Jonas Thiel"
  author_url "http://www.neopoly.de"
  description "Add further fields to the issues reloaded to a version roadmap"
  version "0.0.1"

  requires_redmine_plugin "more_view_hooks", version_or_higher: "0.0.2"

  ActionDispatch::Callbacks.to_prepare do
    require "roadmap_extended_issues_hooks"
  end
end