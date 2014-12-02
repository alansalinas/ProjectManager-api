class AddAttachmentPicaToFotos < ActiveRecord::Migration
  def self.up
    change_table :fotos do |t|
      t.attachment :pica
    end
  end

  def self.down
    remove_attachment :fotos, :pica
  end
end
