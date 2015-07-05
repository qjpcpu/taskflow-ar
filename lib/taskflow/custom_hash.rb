class Taskflow::CustomHash
    class << self
        def load(str)
            return unless str
            HashWithIndifferentAccess.new JSON.parse(str)
        end
        def dump(obj)
            return unless obj
            unless obj.is_a?(HashWithIndifferentAccess) || obj.is_a?(Hash)
                raise ::ActiveRecord::SerializationTypeMismatch,
                    "Attribute was supposed to be a Hash, but was a #{obj.class}. -- #{obj.inspect}"
                    end
            JSON.dump obj
        end
    end
end
