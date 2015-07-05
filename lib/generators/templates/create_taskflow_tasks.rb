class CreateTaskflowTasks < ActiveRecord::Migration
    def change
        create_table :taskflow_tasks do |t|
            t.integer :index, default: 1
            t.string :name
            t.string :klass
            t.string :state
            t.string :result
            t.text :input
            t.text :output
            t.text :data
            t.float :progress, default: 0
            t.datetime :started_at
            t.datetime :ended_at
            t.text :error
            t.integer :flow_id
        end
    end
end
