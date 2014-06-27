module ProjectOverviewPage
  class Hooks < Redmine::Hook::ViewListener
    include ::AttachmentsHelper

    WIKI_PAGES = {
      project_overview: "WikiStart",
      project_sidebar:  "OverviewSidebar"
    }

    def view_projects_show_top(context)
      page = find_wiki_page(context, overview_wiki_title)

      if page
        %(<div class="wiki">#{render_content_for_page(context, page)}</div>)
      end
    end

    def view_projects_contextual(context)
      content = ""

      if find_wiki_page(context, overview_wiki_title)
        content += page_link(context, overview_wiki_title, :edit)
      else
        content += page_link(context, overview_wiki_title, :add)
      end

      if find_wiki_page(context, overview_sidebar_title)
        content += page_link(context, overview_sidebar_title, :edit, l("label_sidebar"))
      else
        content += page_link(context, overview_sidebar_title, :add, l("label_sidebar"))
      end

      content
    end

    def view_projects_show_sidebar_top(context)
      page = find_wiki_page(context, overview_sidebar_title)
      if page
        %(<div class="wiki">#{render_content_for_page(context, page)}</div>)
      end
    end

    private

    def overview_wiki_title
      WIKI_PAGES[:project_overview]
    end

    def overview_sidebar_title
      WIKI_PAGES[:project_sidebar]
    end

    def render_content_for_page(context, page)
      # this rendering must be done through the current view content
      # otherwise textile macros and etc. won't be available
      context[:controller].view_context.textilizable(
        page.content,
        :text,
        attachments: page.attachments,
        project: context[:project]
      )
    end

    def page_link(context, title, action, label = nil)
      link_to(
        label || l("button_#{action}"),
        edit_link_path(context, title),
        class: "icon icon-#{action}",
        accesskey: accesskey(action.to_sym)
      )
    end

    def find_wiki_page(context, title)
      (project = context[:project]) && project.wiki && project.wiki.find_page(title)
    end

    def edit_link_path(context, title)
      edit_project_wiki_page_path(project_id: context[:project].id, id: title)
    end
  end
end
