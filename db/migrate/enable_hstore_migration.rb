# Migration required to enable storing of hashes in DB

class AddHstoreExtension < ActiveRecord::Migration
  def self.up
    enable_extension "hstore"
  end
  def self.down
    disable_extension "hstore"
  end
end
