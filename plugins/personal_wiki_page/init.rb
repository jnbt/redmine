Redmine::Plugin.register :personal_wiki_page do
  name "Personal Wiki page"
  author "Jonas Thiel"
  author_url "http://www.neopoly.de"
  description "Adds a link to a personal wiki page to the header"
  version "0.0.1"

  requires_redmine_plugin "more_view_hooks", version_or_higher: "0.0.1"

  settings :default => {
    'project' => 'orga',
    'prefix'  => 'PersonalWiki_'
  }, :partial => 'settings/personal_wiki_page_settings'

  ActionDispatch::Callbacks.to_prepare do
    require "personal_wiki_page_hooks"
  end
end