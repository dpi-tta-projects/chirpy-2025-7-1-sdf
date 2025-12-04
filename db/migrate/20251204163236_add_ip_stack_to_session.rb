class AddIpStackToSession < ActiveRecord::Migration[8.0]
  def change
    add_column :sessions, :ip_stack, :jsonb, default: {}
  end
end
