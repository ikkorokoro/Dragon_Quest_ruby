class Brave

  # initializeメソッドを定義
  def initialize
    @name = "テリー"
    @hp = 500
    @offense = 150
    @defense = 100
  end

  #インスタンス作成時にinitializeメソッドが呼び出され初期値を設定するためセッター不要のためを削除
  # def name=(name)
  #   @name = name
  # end

  #ゲッター
  def name
    @name
  end

 
  # def hp=(hp)
  #   @hp = hp
  # end

 
  def hp
    @hp
  end

  
  # def offense=(offense)
  #   @offense = offense
  # end

  
  def offense
    @offense
  end

  
  # def defense=(defense) 
  #   @defense = defense
  # end   

  
  def defense
    @defense
  end

  brave = Brave.new
  # インスタンス作成時にinitializeメソッドが呼び出され初期値を設定するため以下不要のためを削除
  # brave.name = "テリー"
  # brave.hp = 500
  # brave.offense = 150
  # brave.defense = 100


  # putsや文字列を囲む""（ダブルクウォーテーション）を何度も書く必要がなくなります。
  # 複数行の文字列を書くときにはこちらの方が楽なのでぜひ使ってみてください。
  puts <<~TEXT
  NAME：#{brave.name}
  HP：#{brave.hp}
  OFFENSE：#{brave.offense}
  DEFENSE：#{brave.defense}
  TEXT
end