class CreateUsers < ActiveRecord::Migration
  def change

    create_table :users do |t|
      t.string     :username
      t.string      :description
      t.string      :profile_image_url
      t.integer    :stale_threshold, :default => 5
    end
  end
end
