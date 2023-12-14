# 技術選定
ADRっぽいもの

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
    - [simple_calendar](https://github.com/excid3/simple_calendar)
    - [Railsのsimple_calendarをカスタマイズして時間帯で予約できる予約機能を作ってみた！](https://qiita.com/sssssatou/items/2e6606e3ddf9b246a0fb)

## メール(追加機能)
- mailの送信はAction Mailerというものがデフォルトであるらしい、すごい
- [Action Mailerの基礎](https://railsguides.jp/action_mailer_basics.html)
- 公式のドキュメントにもあるくらいだし、これ使えってことなのかな
- メールの送信はこれで行こうかなと

## テスト
- こちらは指定があったので、RSpecを使用する
- [RSpec](https://github.com/rspec/rspec-rails)
- [Ruby on Rails のテストフレームワーク RSpec 事始め](https://qiita.com/tatsurou313/items/c923338d2e3c07dfd9ee)
- [FactoryBot](https://github.com/thoughtbot/factory_bot_rails)
    - mockデータを作成するGem
- [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers)
    - model specのバリデーションなどのテストを簡単に検証できるGem
## lint
- [rubocop](https://github.com/rubocop/rubocop-rails)

## Bulk
- https://qiita.com/hiroki_tanaka/items/9ab7eb532fb71e83ffb6
- https://api.rubyonrails.org/classes/ActiveRecord/Batches.html#method-i-in_batches

## Deploy
- herokuとかrender.comみたいなPaaS
- 自分が借りてるVPSにデプロイ
- 時間があったらCloudにデプロイ,GCP使いたい
- DBは高そうなので,Renderとかの無料で使えるやつにする予定 -> postgresしかなかった
- DBはMySQLを無料で使える[PlanetScale](https://planetscale.com/)
    - 無料枠があり、テーブルの可視化やレイテンシなどのメトリックス可視化も行ってくれる
- RailsはRender.comにデプロイすることにした

## CI
- github actionsを使用する
- RSpecとRubocopを回す(push: [main, develop], pull_requests: [main, develop])
- アプリケーションの更新はmainにpush時にRenderが検知して自動でやってくれる
