class Brave
  attr_reader :name, :offense, :defense
  attr_accessor :hp

  # 必殺攻撃の計算に使う定数
  SPECIAL_ATTACK_CONSTANT = 1.5

  def initialize(params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

  def attack(monster)
    puts "#{@name}の攻撃"

    # 0~3の間でランダムに数字が変わる
    attack_num = rand(4)

    # 4分の1の確率でspecial_attackを実行
    if attack_num == 0
      puts "必殺攻撃"
      # calculate_special_attackの呼び出し
      damage = calculate_special_attack - monster.defense
    else
      puts "通常攻撃"
      damage = @offense - monster.defense
    end

    # ダメージを与えられたHPをモンスターインスタンスのHPに代入(自己代入記法)
    monster.hp -= damage

    monster.hp = 0 if monster.hp < 0

    puts "#{monster.name}は#{damage}のダメージを受けた"
    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  def calculate_special_attack
    # 攻撃力が1.5倍
    @offense * SPECIAL_ATTACK_CONSTANT
  end
end

class Monster
  # nameを削除
  attr_reader :offense, :defense
  # nameを追加
  attr_accessor :hp, :name

  POWER_UP_RATE = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]

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

    # ダメージ反映処理の呼び出し
    cause_damage(target: brave, damage: damage)
    
    #もしターゲットが0以下ならhpを０を代入する
    brave.hp = 0 if brave.hp < 0

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
  monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)
  brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
  
  #loop によって以下の処理が無限繰り返し処理される
  loop do
    brave.attack(monster)
    break if monster.hp <= 0
      
    monster.attack(brave)
    break if brave.hp <= 0
  end