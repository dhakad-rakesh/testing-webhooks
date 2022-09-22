class CreateJoinTableBetTypesPlayTypes < ActiveRecord::Migration[5.2]
  def change
    create_join_table :bet_types, :play_types do |t|
      t.index %I[bet_type_id play_type_id]
      t.index %I[play_type_id bet_type_id]
    end
  end
end
