class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :body
      t.string :sender
      t.string :receiver
      t.timestamps
    end
  end
end
