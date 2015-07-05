class CreateTaskflowLoggers < ActiveRecord::Migration
    def change
        create_table :taskflow_loggers do |t|
            t.string :name
            t.string :description
            t.datetime :created_at
            t.integer :flow_id

        end
    end
end
