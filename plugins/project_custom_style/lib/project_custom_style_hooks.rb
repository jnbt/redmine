module ProjectCustomStyle
  class Hooks < Redmine::Hook::ViewListener
    WIKI_PAGES = {
      project_styles: "CustomStyle"
    }

    def view_layouts_base_html_head(context)
      page = find_wiki_page(context)
      page.content.text if page
    end

    def view_projects_contextual(context)
      link_to(
        l("label_custom_style"),
        edit_path(context),
        class: "icon icon-copy"
      )
    end

    private

    def edit_path(context)
      edit_project_wiki_page_path(
        project_id: context[:project].id,
        id: custom_style_wiki_page
      )
    end

    def custom_style_wiki_page
      WIKI_PAGES[:project_styles]
    end

    def find_wiki_page(context)
      (project = context[:project]) && project.wiki && project.wiki.find_page(custom_style_wiki_page)
    end
  end
end
