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
end
