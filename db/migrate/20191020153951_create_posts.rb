class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      # ToDoのタイトル
      t.string :title, null: false
      # 締め切り
      t.datetime :target_at, null: true
      # 何ポイントのタスクか
      t.integer :point, null: false, default: 0
      # todoが完了したか (trueになったらポイント付与)
      t.boolean :completed, null: false, default: false
      # user tableに紐付け (外部キー制約あり)
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
