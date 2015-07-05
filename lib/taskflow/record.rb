class Taskflow::Record < ActiveRecord::Base

    belongs_to :tflogger,:class_name=>'Taskflow::Logger',:inverse_of=>:records
    serialize :tags, JSON

    before_save :set_default_property

    private
    def set_default_property
        self.tags ||= {}
        self.written_at ||= Time.now
    end
end
