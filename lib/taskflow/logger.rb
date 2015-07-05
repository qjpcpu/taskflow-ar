class Taskflow::Logger < ActiveRecord::Base

    belongs_to :flow, :class_name=>'Taskflow::Flow',:inverse_of=>:tflogger

    has_many :records,:class_name=>'Taskflow::Record',:inverse_of=>:tflogger

    before_save :set_default_property
    def log(content,options={})
        raise 'Need step id to write a log' if options[:step_id].nil? && @step_id.nil?
        options[:step_id] ||= @step_id
        options[:writer] ||= @writer
        @step_id ||= options[:step_id]
        @writer ||= options[:writer]
        options.merge! :content=>content
        record = self.records.last
        if record && options.all?{|k,v| record.send(k) == v }
            record.update_attributes! written_at: Time.now
        else
            self.records.create options
        end
    end

    def info(content,options={})
        options.merge!(:level=>'INFO')
        self.log content,options
    end

    def error(content,options={})
        options.merge!(:level=>'ERROR')
        self.log content,options
    end

    def fatal(content,options={})
        options.merge!(:level=>'FATAL')
        self.log content,options
    end

    def warning(content,options={})
        options.merge!(:level=>'WARNING')
        self.log content,options
    end

    def debug(content,options={})
        options.merge!(:level=>'DEBUG')
        self.log content,options
    end

    private
    def set_default_property
        self.created_at ||= Time.now
    end
end
