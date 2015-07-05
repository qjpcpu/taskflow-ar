class CreateTaskflowDownstreams < ActiveRecord::Migration
    def change
        create_table :taskflow_downstreams, :id=>false do |t|
            t.integer :downstream_id
            t.integer :task_id
        end

    end
end
