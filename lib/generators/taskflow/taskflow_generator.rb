require 'rails/generators/named_base'
require 'rails/generators/active_record'

module Taskflow

    class TaskflowGenerator < ActiveRecord::Generators::Base

        include Rails::Generators::ResourceHelpers

        namespace "taskflow"

        desc "Creates Taskflow Migrations"

        source_root File.expand_path("../../templates", __FILE__)

        def migration
            migration_template "create_taskflow_flows.rb", "db/migrate/create_taskflow_flows.rb"
            migration_template "create_taskflow_tasks.rb", "db/migrate/create_taskflow_tasks.rb"
            migration_template "create_taskflow_loggers.rb", "db/migrate/create_taskflow_loggers.rb"
            migration_template "create_taskflow_records.rb", "db/migrate/create_taskflow_records.rb"
            migration_template "create_taskflow_downstreams.rb", "db/migrate/create_taskflow_downstreams.rb"
            migration_template "create_taskflow_upstreams.rb", "db/migrate/create_taskflow_upstreams.rb"
        end
    end

end
