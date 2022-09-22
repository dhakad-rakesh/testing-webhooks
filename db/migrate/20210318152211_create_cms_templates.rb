class CreateCmsTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :cms_templates do |t|
      t.text :content
      t.string :subject
      t.integer :template_for, default: 0
      t.datetime :schedule_at

      t.timestamps
    end

    add_index :cms_templates, %I[template_for schedule_at]
  end
end
