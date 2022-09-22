class AddStreamingUrlToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :streaming_url, :string
  end
end
