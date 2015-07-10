require "taskflow/version"
require 'active_support/core_ext/hash/indifferent_access'
require 'taskflow/custom_hash'
require 'taskflow/flow'
require 'taskflow/task'
require 'taskflow/worker'
require 'taskflow/logger'
require 'taskflow/record'

module Taskflow
    def self.table_name_prefix
        'taskflow_'
    end

    def self.worker_options=(opts)
        orig = HashWithIndifferentAccess.new(Worker.sidekiq_options_hash || {})
        Worker.sidekiq_options_hash = orig.merge(opts).merge(retry: false)
    end
    
    def self.configure
        yield self
    end
end
