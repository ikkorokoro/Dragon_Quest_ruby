class Brave
  attr_reader :name, :hp, :offense, :defense
  attr_accessor :hp
  
  def initialize(**params)
    @name = params[:name]
    @hp = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]
  end

end

  brave = Brave.new(name: "テリー", hp: 500, offense: 150, defense: 100)

  puts <<~TEXT
  NAME：#{brave.name}
  HP：#{brave.hp}
  OFFENSE：#{brave.offense}
  DEFENSE：#{brave.defense}
  TEXT

  brave.hp -= 30
  puts "#{brave.name}はダメージを受けた！残りHPは#{brave.hp}"

class Monster
  # 値の取り出しのみ可能
  attr_reader :name, :offense, :defense
  # 値の代入・取り出しが可能
  attr_accessor :hp
  
  # **paramsにすることでハッシュ形式の引数しか受け付けないようにできる
  def initialize(**params)
    @name = params[:name]
    @np = params[:hp]
    @offense = params[:offense]
    @defense = params[:defense]   
  end

  # ハッシュ形式でデータを渡すのでどういうデータを渡しているのか把握しやすくなる
  monster = Monster.new(name: "スライム", hp: 250, offense: 200, defense: 100)
end