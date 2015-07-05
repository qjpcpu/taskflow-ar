class CreateTaskflowFlows < ActiveRecord::Migration
    def change
        create_table :taskflow_flows do |t|
            t.string :name
            t.string :klass
            t.string :state
            t.string :category
            t.string :result
            t.string :launched_by
            t.string :halt_by
            t.text :input
            t.float :progress
            t.datetime :started_at
            t.datetime :ended_at
            t.text :next_config
        end
    end
end
