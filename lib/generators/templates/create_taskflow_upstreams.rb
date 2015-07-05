class CreateTaskflowUpstreams < ActiveRecord::Migration
    def change
        create_table :taskflow_upstreams, :id=>false do |t|
            t.integer :upstream_id
            t.integer :task_id
        end

    end
end
