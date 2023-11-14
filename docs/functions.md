# 前提条件
## アプリケーション
- 一般ユーザーがFP(ファイナンシャルプランナー)に相談できるアプリケーション
- 相談を予約するシステムを構築する

## 仕様・要件
- ユーザーおよびFPの登録
- 指定したユーザーでのログイン・ログアウト
- 予約枠は一枠30分
- 平日10:00~18:00
- 土11:00~15:00
- 日休み
- FPが予約を受け付ける枠を設定 -> 一般ユーザーが予約

# 必要機能の洗い出し
- ユーザーとFPを区別する必要がある。
    - 別のテーブルを用意する
        - テーブルが増えるが、一般ユーザーとFPで必要なデータが違う時管理が楽になる。
    - Enum等でRoleを付与する。Userテーブルにroleカラムを用意する
        - 共通のテーブルで管理する。片方しか必要がない情報に関してはNullで管理する必要がある。
- ユーザーとFPはそれぞれマイページを用意する。
- カレンダーを用意して、FPが自分の入れる日を選択できるようにする。
- ユーザーはFPが入れた日の時間のみ予約が可能になる。
- ユーザーが予約を入れたタイミングでは仮予約として扱う。
- 仮予約が完了すると相談予定のFPに対してメールが送られる。
- FPはマイページで仮予約と本予約の確認ができる。
- 仮予約は確定と取り消しができ、確定を行うと予約が確定し、取り消しを行うと仮予約は取り消しとなる。