class CreateCalendarToQueueQueues < ActiveRecord::Migration
  def change
    create_table :calendar_to_queue_queues do |t|
      t.string :name
      t.string :url
      t.timestamps null: false
    end
  end
end
