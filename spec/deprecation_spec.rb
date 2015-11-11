require 'spec_helper'

describe Object do
  describe ".deprecate" do
    it "add deprecation warning to method" do
      class Foo
        def baz; end
      end
      expect { Foo.new.baz }.not_to output(/DEPRECATION/).to_stderr

      class Foo
        using DeprecationWarner

        def bar; end
        deprecate :baz, :bar
      end
      expect(Foo.new).to respond_to(:baz)
      expect { Foo.new.baz }.to output(/DEPRECATION/).to_stderr
    end
  end
end
