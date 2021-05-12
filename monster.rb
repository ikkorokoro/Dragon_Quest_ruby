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

    # メッセージを追記
    puts "#{monster.name}は#{damage}のダメージを受けた"
    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end

  def calculate_special_attack
    # 攻撃力が1.5倍
    @offense * SPECIAL_ATTACK_CONSTANT
  end
end

class Monster
  attr_reader :name, :offense, :defense
  attr_accessor :hp

  POWER_UP_RATE = 1.5
  CALC_HALF_HP = 0.5

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]

    # モンスターが変身したかどうかを判定するフラグ
      @transform_flag == false
    # 変身する際の閾値（トリガー）を計算
      @trigger_of_transform = params[:hp] * CALC_HALF_HP
    
    def attack(brave)
      if @hp <= @trigger_of_transform && @transform_flag == false
        @transform_flag == true
        transtorm
      end
      puts "#{@name}の攻撃"
      damage = @offense - brave.defense
      brave.hp -= damage
    end
  end

  private

  def transform
    
  end
end
  
  monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)
  brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
  brave.attack(monster)
  monster.attack(brave)