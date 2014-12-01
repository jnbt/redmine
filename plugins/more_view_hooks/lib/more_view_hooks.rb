module MoreViewHooks
  module InjectHooks
    class Hook
      attr_reader :deface_options

      def initialize(hook_name, context, options)
        @deface_options = options.merge(
          text: "<%= call_hook(:#{hook_name}, #{context || "{}"}) %>",
          name: "more_view_hooks_#{hook_name}"
        )
      end

      def apply!
        Deface::Override.new(deface_options)
      end
    end

    HOOKS = []

    def apply!
      HOOKS.each(&:apply!)
      HOOKS.freeze
    end
    module_function :apply!

    def add(name, options)
      context = options.delete(:context)
      HOOKS << Hook.new(name, context, options)
    end
    module_function :add

    add(:view_projects_contextual,
      virtual_path: "projects/show",
      insert_top: "div.contextual"
    )

    add(:view_projects_show_top,
      virtual_path: "projects/show",
      insert_before: "div.splitcontentleft"
    )

    add(:view_projects_show_bottom,
      virtual_path: "projects/show",
      insert_after: "div.splitcontentright"
    )

    add(:view_projects_show_sidebar_top,
      virtual_path: "projects/_sidebar",
      insert_before: "erb[silent]:contains('if @total_hours.present?')"
    )
  end
end
