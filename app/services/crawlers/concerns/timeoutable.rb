module Crawlers
  module Concerns
    module Timeoutable
      def before(method, options)
        old_method = instance_method(method)
        define_method(method) do
          send(options[:call])
          old_method.bind(self).call
        end
      end
    end
  end
end
