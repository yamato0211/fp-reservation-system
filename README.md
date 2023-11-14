# README

## FP相談アプリケーション

[ドキュメント](./docs/)

### 起動方法

以下コマンドは初回のみ
```
docker compose build
docker compose run web rails db:create
```

起動
```
docker compose up 
```

バックグラウンド実行
```
docker compose up -d 
```

Gemfileを更新した場合はBuildから行う




