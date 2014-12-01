Redmine::Plugin.register :project_overview_page do
  name "Redmine Project Overview Page"
  author "Jonas Thiel"
  author_url "http://www.neopoly.de"
  description "Uses a special wiki page 'WikiStart' as the projects " \
              "start page and a speical page 'OverviewSidebar' " \
              "as a sidebar for the start page"
  version "0.0.1"

  requires_redmine_plugin "more_view_hooks", version_or_higher: "0.0.3"

  ActionDispatch::Callbacks.to_prepare do
    require "project_overview_page_hooks"
  end
end
