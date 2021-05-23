# クラスの継承
=begin
こちらでは、クラスの継承を行い、勇者クラスやモンスタークラスをさらにシンプルに記述できるようにしていきます。
クラスの継承とは、既にあるクラスの持っている情報や振る舞いを利用し、さらに拡張したクラスを作成することです。
今回のプログラムで言えば、勇者クラスとモンスタークラスがありますが、それらのクラスは保持するインスタンス変数や定義されているメソッドについて共通している部分が多くみられます。
その共通部分を「親クラス」として切り出すことで、その親クラスを継承した子クラスは、親クラスにないインスタンス変数やメソッドを定義するだけで良くなります。
実際に共通部分を切り出し、親クラスの定義、親クラスの継承、クラスの拡張を行いながら、継承を利用するメリットについて触れていきましょう。クラスの構成としては以下のようにしていきます。
=end
#共通化しているパラメータを親クラスに定義し、クラスの継承を行うことで重複しているコードを無くし、可読性をあげる

class Character
  attr_reader :offense, :defense
  attr_accessor :name, :hp

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end
end

class Brave < Character
  # 必殺攻撃の計算に使う定数
  SPECIAL_ATTACK_CONSTANT = 1.5

  def attack(monster)
    puts "#{@name}の攻撃"

    attack_type = decision_attack_type
    damage = calculate_damage(target: monster, attack_type: attack_type)
    cause_damage(target: monster, damage: damage)

    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  private

  def decision_attack_type
    attack_num = rand(4)

    if attack_num == 0
      puts "必殺攻撃"
      "special_attack"
    else
      puts "通常攻撃"
      "normal_attack"
    end
  end

  def calculate_damage(**params)
    target = params[:target]
    attack_type = params[:attack_type]

    if attack_type == "special_attack"
      calculate_special_attack - target.defense
    else
      @offense - target.defense
    end
  end

  def cause_damage(**params)
    damage = params[:damage]
    target = params[:target]

    target.hp -= damage
    target.hp = 0 if target.hp < 0

    puts "#{target.name}は#{damage}のダメージを受けた"
    puts "#{target.name}の残りHPは#{target.hp}だ"
  end

  def calculate_special_attack
    # 攻撃力が1.5倍
    @offense * SPECIAL_ATTACK_CONSTANT
  end
end

class Monster < Character

  def attack(monster)
    puts "#{@name}の攻撃"

    attack_type = decision_attack_type
    damage = calculate_damage(target: monster, attack_type: attack_type)
    cause_damage(target: monster, damage: damage)

    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  private

    def decision_attack_type
      attack_num = rand(4)

      if attack_num == 0
        puts "必殺攻撃"
        "special_attack"
      else
        puts "通常攻撃"
        "normal_attack"
      end
    end

    def calculate_damage(**params)
      target = params[:target]
      attack_type = params[:attack_type]

      if attack_type == "special_attack"
        calculate_special_attack - target.defense
      else
        @offense - target.defense
      end
    end

    def cause_damage(**params)
      damage = params[:damage]
      target = params[:target]

      target.hp -= damage
      target.hp = 0 if target.hp < 0

      puts "#{target.name}は#{damage}のダメージを受けた"
    end

    def calculate_special_attack
      @offense * SPECIAL_ATTACK_CONSTANT
    end
end

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

    puts "#{@name}の攻撃"

    damage = calculate_damage(brave)
    cause_damage(target: brave, damage: damage)

    puts "#{brave.name}の残りHPは#{brave.hp}だ"
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

      puts "#{target.name}は#{damage}のダメージを受けた"
    end

    def transform
      transform_name = "ドラゴン"

      puts <<~EOS
      #{@name}は怒っている
      #{@name}は#{transform_name}に変身した
      EOS

      @offense *= POWER_UP_RATE
      @name = transform_name
    end
end

brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)

loop do
  brave.attack(monster)
  break if monster.hp <= 0

  monster.attack(brave)
  break if brave.hp <= 0
end

battle_result = brave.hp > 0

if battle_result
  exp = (monster.offense + monster.defense) * 2
  gold = (monster.offense + monster.defense) * 3
  puts "#{brave.name}はたたかいに勝った"
  puts "#{exp}の経験値と#{gold}ゴールドを獲得した"
else
  puts "#{brave.name}はたたかいに負けた"
  puts "目の前が真っ暗になった"
end

=begin
＊注１
initializeメソッドに関しては、モンスタークラスとキャラクタークラスとでは「共通している部分」と「共通していない部分」があります。
「共通している部分」だけを削除し、「共通していない部分」を残すにはどうすればいいでしょう？
共通しているパラメータ	
name, hp, offense defense	

共通していないパラメータ
transform_flag, threshold_of_transform
そのような時に使用するのがsuperというメソッドです。
superは、実行しているメソッドがオーバーライドしているメソッドを呼び出します。
オーバーライドとは「親クラスのメソッドを子クラスで上書きすること」です。
今回の例であれば、キャラクタークラスのinitializeメソッドをモンスタークラスのinitializeメソッドで上書きすることを指します。
そして、モンスタークラスのinitializeメソッド中でsuperを使うことにより、キャラクタークラスのinitializeメソッドを実行することができます。
これにより、「共通している部分」と「共通していない部分」で処理を振り分けることができるようになります。
=end