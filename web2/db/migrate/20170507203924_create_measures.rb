class CreateMeasures < ActiveRecord::Migration[5.0]
  def change
    create_table :measures do |t|
      t.references :user
      t.float :lat
      t.float :lng
      t.integer :kind
      t.float :value
      t.string :color

      t.timestamps
    end
  end
end
