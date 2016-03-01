class CreateCalendarToQueueGoogleCalendarPushes < ActiveRecord::Migration
  def change
    create_table :calendar_to_queue_google_calendar_pushes do |t|
      t.string :channel_id
      t.integer :message_number
      t.string :resource_id
      t.string :state
      t.string :resource_uri
      t.timestamp :expiration
      t.string :token

      t.timestamps null: false
    end
  end
end
