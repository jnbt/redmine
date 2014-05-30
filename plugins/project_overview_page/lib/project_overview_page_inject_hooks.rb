module ProjectOverviewPage
  module InjectHooks
    class Hook
      attr_reader :deface_options

      def initialize(hook_name, options)
        @deface_options = options.merge(
          virtual_path: "projects/show",
          text: "<%= call_hook(:#{hook_name}) %>",
          name: "project_over_page_hook_#{hook_name}"
        )
      end

      def apply!
        Deface::Override.new(deface_options)
      end
    end

    HOOKS = [
      Hook.new(:view_projects_contextual,
        insert_top: "div.contextual"
      ),
      Hook.new(:view_projects_show_top,
        insert_before: "div.splitcontentleft"
      ),
      Hook.new(:view_projects_show_bottom,
        insert_after: "div.splitcontentright"
      ),
      Hook.new(:view_projects_show_sidebar_top,
        insert_before: "erb[silent]:contains('if @total_hours.present?')"
      )
    ]

    def apply!
      HOOKS.each(&:apply!)
    end
    module_function :apply!
  end
end
