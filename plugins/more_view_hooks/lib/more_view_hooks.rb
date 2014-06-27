module MoreViewHooks
  module InjectHooks
    class Hook
      attr_reader :deface_options

      def initialize(hook_name, options)
        @deface_options = options.merge(
          text: "<%= call_hook(:#{hook_name}) %>",
          name: "more_view_hooks_#{hook_name}"
        )
      end

      def apply!
        Deface::Override.new(deface_options)
      end
    end

    HOOKS = [
      Hook.new(:view_projects_contextual,
        virtual_path: "projects/show",
        insert_top: "div.contextual"
      ),
      Hook.new(:view_projects_show_top,
        virtual_path: "projects/show",
        insert_before: "div.splitcontentleft"
      ),
      Hook.new(:view_projects_show_bottom,
        virtual_path: "projects/show",
        insert_after: "div.splitcontentright"
      ),
      Hook.new(:view_projects_show_sidebar_top,
        virtual_path: "projects/show",
        insert_before: "erb[silent]:contains('if @total_hours.present?')"
      )
    ]

    def apply!
      HOOKS.each(&:apply!)
    end
    module_function :apply!
  end
end
