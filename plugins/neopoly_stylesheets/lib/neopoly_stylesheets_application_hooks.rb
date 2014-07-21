module NeopolyStylesheets
  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(_context)
      stylesheet_link_tag "neopoly_stylesheets", plugin: "neopoly_stylesheets"
    end
  end
end
