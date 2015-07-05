class CreateTaskflowRecords < ActiveRecord::Migration
    def change
        create_table :taskflow_records do |t|
            t.integer :step_id
            t.string :writer
            t.string :level
            t.string :content
            t.text :tags
            t.datetime :written_at
            t.integer :tflogger_id
        end
    end
end
