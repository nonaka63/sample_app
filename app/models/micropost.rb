class Micropost < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 140 }
  #制約　　　　　　　　必須         　最大文字数
  validates :user_id, presence: true
  
#基本的にプログラムの宣言は上に集めるのがセオリーです。変数の宣言も同じく上
#micropost model 　file属性の追加  ※ファイルの宣言のみ。→宣言は上に集める（rails）。
 has_attached_file :image, styles: { medium: "280x150>", thumb: "50x50>" }
#画像拡張子を限定する記述　これも上の行と同じ
 validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image /png image/gif)

#↓は更に区分として下のエリアのことを決めている。・・・有効範囲を意識すること。
#これを意識しておかないと、参照する範囲がぐちゃぐちゃになっていく。

  def self.from_users_followed_by(user)
    followed_user_ids = "SELECT followed_id FROM relationships
                         WHERE follower_id = :user_id"
    where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
          user_id: user.id)
  end
end
