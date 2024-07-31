class AddWebsocketUuidToChats < ActiveRecord::Migration[7.1]
  def change
    add_column :chats, :websocket_uuid, :uuid, null: false
  end
end
