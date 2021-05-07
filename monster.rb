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
    puts "テスト: #{monster.name}のHPを表示 => #{monster.hp}"
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
  