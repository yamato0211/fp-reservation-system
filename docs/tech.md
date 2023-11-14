# 技術選定

## 環境構築
- dockerで管理する
- docker composeでrailsとdbを立ち上げられるようにする

## 認証・認可
- devise
    - rails認証と調べるとすぐ出てきた。
    - railsで最もメジャーな認証系Gemらしい
    - star数が23kもある
    - 最近までCommitがあって良い
    - ドキュメントも充実してそう [devise](https://github.com/heartcombo/devise#getting-started)
    - sessionの管理なども行ってくれる
- authlogic
    - deviseの他に何かないかなと調べてたら出てきた
    - [authlogic](https://github.com/binarylogic/authlogic)
    - star4.3k
    - 古そう
    - そこまで整備されていない
    - 使い方的にDeviseと差異はほとんどなさそう
- 自作
    - deviseを使わずともスクラッチで作るもできるらしい
    - [deviseを使わずにログイン機能を実装する方法](https://kodyblog.com/rails-not-use-devise/)
    - 見た感じ自分でSessionの管理やパスワード変更ロジックを提供してあげる必要がある
    - そこまで工数をかけたくはないので、今回はDeviseで行こうかな

## 予約管理
- よく見る予約アプリみたくカレンダーを描画して、その時間に◯×を表示して予約できるかをやりたい
- simple_calender
    - 見つけた。まんまこれ
    - [simple_calendar](https://github.com/excid3/simple_calendar)
    - [Railsのsimple_calendarをカスタマイズして時間帯で予約できる予約機能を作ってみた！](https://qiita.com/sssssatou/items/2e6606e3ddf9b246a0fb)

## メール
- mailの送信はAction Mailerというものがデフォルトであるらしい、すごい
- [Action Mailerの基礎](https://railsguides.jp/action_mailer_basics.html)
- 公式のドキュメントにもあるくらいだし、これ使えってことなのかな
- メールの送信はこれで行こうかなと

## テスト
- こちらは指定があったので、RSpecを使用する
- [RSpec](https://github.com/rspec/rspec-rails)
- [Ruby on Rails のテストフレームワーク RSpec 事始め](https://qiita.com/tatsurou313/items/c923338d2e3c07dfd9ee)

## Deploy
- 正直なんでもいい
- herokuとかrender.comみたいなPaaSでもいいし
- 自分が借りてるVPSにデプロイでも良いかなとか
- 時間があったらCloudにデプロイしようかなGCP使いたい
- DBは高そうだからRenderとかの無料で使えるやつにする予定