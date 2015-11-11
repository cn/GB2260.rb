module ArrayExtensions
  refine Array do
    [:select, :reject].each do |action|
      [:start, :end].each do |position|
        define_method "#{action}_#{position}_with".to_sym do |predicate|
          self.send(action) { |c| c.send("#{position}_with?".to_sym, predicate) }
        end
      end
    end
  end
end
