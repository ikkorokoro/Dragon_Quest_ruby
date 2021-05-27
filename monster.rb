require './character'

class Monster < Character

  POWER_UP_RATE = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    # キャラクタークラスのinitializeメソッドに処理を渡す
    # 通常のメソッドと同様に引数を渡すことができる
    super(
      name: params[:name],
      hp: params[:hp],
      offense: params[:offense],
      defense: params[:defense]
    )
    # 親クラスで定義していない処理はそのまま残す
    @transform_flag = false
    @trigger_of_transform = params[:hp] * CALC_HALF_HP
  end

  def attack(brave)
    if @hp <= @trigger_of_transform && @transform_flag == false
      @transform_flag = true
      transform
    end

    # puts "#{@name}の攻撃"

    damage = calculate_damage(brave)
    cause_damage(target: brave, damage: damage)

    attack_message
    damage_message(target: brave, damage: damage)
    # puts "#{brave.name}の残りHPは#{brave.hp}だ"
  end

  private

    def calculate_damage(target)
      @offense - target.defense
    end

    def cause_damage(**params)
      damage = params[:damage]
      target = params[:target]

      target.hp -= damage
      target.hp = 0 if target.hp < 0

      # puts "#{target.name}は#{damage}のダメージを受けた"
    end

    def transform
      transform_name = "ドラゴン"

      transform_message(origin_name: @name, transform_name: transform_name)

      @offense *= POWER_UP_RATE
      @name = transform_name
    end
end

=begin
＊注１
initializeメソッドに関しては、モンスタークラスとキャラクタークラスとでは「共通している部分」と「共通していない部分」があります。
「共通している部分」だけを削除し、「共通していない部分」を残す
共通しているパラメータ	
name, hp, offense defense	

共通していないパラメータ1
transform_flag, threshold_of_transform

そのような時に使用するのがsuperというメソッドです。
superは、実行しているメソッドがオーバーライドしているメソッドを呼び出します。
オーバーライドとは「親クラスのメソッドを子クラスで上書きすること」です。
今回の例であれば、キャラクタークラスのinitializeメソッドをモンスタークラスのinitializeメソッドで上書きすることを指します。
そして、モンスタークラスのinitializeメソッド中でsuperを使うことにより、キャラクタークラスのinitializeメソッドを実行することができます。
これにより、「共通している部分」と「共通していない部分」で処理を振り分けることができるようになります。
=end

