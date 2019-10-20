class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      # ご褒美のタイトル
      t.string :title, null: false
      # 何ポイントのご褒美か
      t.integer :point, null: true
      # ご褒美をもらったか (trueになったらget ポイントが減る処理)
      t.boolean :completed, null: false, default: false
      # user tableに紐付け (外部キー制約あり)
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
