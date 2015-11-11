module DeprecationWarner
  refine Module do
    def deprecate(old_method, new_method)
      define_method(old_method) do |*args, &block|
        warn "[DEPRECATION] `#{old_method}` is deprecated.  Please use `#{new_method}` instead."
        send(new_method, *args, &block)
      end
    end
  end
end
