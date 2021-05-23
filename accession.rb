# クラスの継承
=begin
こちらでは、クラスの継承を行い、勇者クラスやモンスタークラスをさらにシンプルに記述できるようにしていきます。
クラスの継承とは、既にあるクラスの持っている情報や振る舞いを利用し、さらに拡張したクラスを作成することです。
今回のプログラムで言えば、勇者クラスとモンスタークラスがありますが、それらのクラスは保持するインスタンス変数や定義されているメソッドについて共通している部分が多くみられます。
その共通部分を「親クラス」として切り出すことで、その親クラスを継承した子クラスは、親クラスにないインスタンス変数やメソッドを定義するだけで良くなります。
実際に共通部分を切り出し、親クラスの定義、親クラスの継承、クラスの拡張を行いながら、継承を利用するメリットについて触れていきましょう。クラスの構成としては以下のようにしていきます。
=end
#共通化しているパラメータを親クラスに定義し、クラスの継承を行うことで重複しているコードを無くし、可読性をあげる

#別ファイルを読み込む

require './brave'
require './monster'

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