# coding: utf-8
class Taskflow::Task < ActiveRecord::Base
    # do not save myself in up or downstream
    before_save :remove_self_in_stream

    serialize :data, Taskflow::CustomHash
    serialize :input, Taskflow::CustomHash
    serialize :output, Taskflow::CustomHash
    serialize :error, Taskflow::CustomHash


    before_save :set_default_property
    has_and_belongs_to_many :downstream, :class_name=>'Taskflow::Task',:inverse_of=>:upstream,:join_table=> :taskflow_relation,:foreign_key=> 'upstream_id'
    has_and_belongs_to_many :upstream, :class_name=>'Taskflow::Task',:inverse_of=>:downstream,:join_table=> :taskflow_relation,:foreign_key=> 'downstream_id'

    belongs_to :flow,:class_name=>'Taskflow::Flow',:inverse_of=>:tasks

    def go(sidekiq_logger)
        raise NotImplementedError
    end

    def resume
        if self.state == 'paused' && self.result == 'error'
            self.flow.update_attributes! state: 'running'
            Taskflow::Worker.perform_async self.flow.id.to_s,self.id.to_s
        end
    end

    def wakeup(arguments={})
        self.reload
        if self.state == 'paused' && self.result == 'suspend'
            self.data = self.data.merge arguments
            self.result = nil
            self.save
            Taskflow::Worker.perform_async self.flow.id.to_s,self.id.to_s
        end
    end

    def skip
        self.reload
        if self.state == 'paused'
            self.update_attributes! state: 'skipped'
            Taskflow::Worker.perform_async self.flow.id.to_s,self.id.to_s
        end
    end

    private

    def remove_self_in_stream
        downstream.delete self if downstream.include? self
        upstream.delete self if upstream.include? self
    end

    def suspend
        throw :control,:suspend
    end

    def tflogger
        @tflogger ||= (
            _logger = flow.tflogger
            _logger.instance_variable_set '@step_id',self.index
            _logger.instance_variable_set '@writer',self.name
            _logger
        )
    end

    def method_missing(name,*args)
        if /^(set|append|clear)_(input|output|data)$/ =~ name.to_s
            act,fd = name.to_s.split '_'
            if act == 'set'
                return false unless args.first
                self.update_attributes! "#{fd}"=>args.first
            elsif act == 'append'
                return false unless args.first
                self.update_attributes! "#{fd}"=>self.send("#{fd}").merge(args.first)
            else
                self.update_attributes! "#{fd}"=>{}
            end
        else
            super
        end
    end

    def set_default_property
        self.klass ||= self.class.to_s
        self.state ||= 'pending'
        self.input ||= {}
        self.output ||= {}
        self.data ||= {}
    end
end
