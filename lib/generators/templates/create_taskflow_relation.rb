class CreateTaskflowRelation < ActiveRecord::Migration
    def change
        create_table :taskflow_relation, :id=>false do |t|
            t.integer :downstream_id
            t.integer :upstream_id
            t.integer :task_id
        end

    end
end
