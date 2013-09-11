class CreateAcGenerators < ActiveRecord::Migration
  def change
    create_table :ac_generators do |t|

      t.timestamps
    end
  end
end
