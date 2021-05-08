class Brave
  attr_reader :name, :offense, :defense
  attr_accessor :hp
  
  def initialize(params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

  def attack(monster)
    damage = @offense - monster.defense
    # ダメージを与えられたHPをモンスターインスタンスのHPに代入(自己代入記法)
    monster.hp -= damage
    # メッセージを追記
    puts "#{@name}の攻撃"
    puts "#{monster.name}は#{damage}のダメージを受けた"
    puts "#{monster.name}の残りHPは#{monster.hp}だ"
  end
end



class Monster
  attr_reader :name, :offense, :defense
  attr_accessor :hp

  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]   
  end
end
  
  monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)
  brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)
  brave.attack(monster)
  