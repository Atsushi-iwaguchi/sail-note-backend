# Sail Note Backend

ヨット部向け練習記録管理アプリ「Sail Note」のバックエンドリポジトリです。

アプリURL: https://sailnote-app.com

**フロントエンドリポジトリ**: https://github.com/Atsushi-iwaguchi/sail-note-frontend

## 概要

ヨット部の練習記録・大会成績・月間目標を一元管理し、部員間で情報を共有できるWebアプリのAPIサーバーです。


## 主な機能・API

- ユーザー登録・ログイン（JWT認証）
- 練習記録のCRUD（風向・風速・潮汐・艇のセッティング等）
- 練習記録へのコメント機能
- 大会・レース結果の管理（大会登録 → エントリー → レース結果の階層構造）
- 月間目標のCRUD
- 天気APIとの連携（Open-Meteo APIを利用し、練習日の天気・気温を自動取得）

### エンドポイント例

| メソッド | パス | 用途 |
|---|---|---|
| POST | /api/v1/auth/register | ユーザー登録 |
| POST | /api/v1/auth/login | ログイン |
| GET | /api/v1/me | ログインユーザー情報取得 |
| CRUD | /api/v1/practice_records | 練習記録 |
| CRUD | /api/v1/practice_records/:id/comments | 練習記録へのコメント |
| CRUD | /api/v1/tournaments | 大会 |
| CRUD | /api/v1/tournaments/:id/tournament_entries | 大会エントリー |
| CRUD | /api/v1/tournament_entries/:id/race_results | レース結果 |
| CRUD | /api/v1/monthly_goals | 月間目標 |

## 使用技術

| カテゴリー | 技術 |
|---|---|
| フレームワーク | Ruby on Rails 8.1.3.1（APIモード） |
| 言語 | Ruby 3.4.9 |
| データベース | PostgreSQL 16 |
| 認証 | jwt / bcrypt |
| インフラ | AWS（EC2 / RDS / S3 ） |
| 環境構築 | Docker |
| CI/CD | GitHub Actions（RuboCop / Brakeman / bundler-audit / テスト自動実行） |
| テスト | RSpec / RuboCop |

## 設計資料

- インフラ図: （フロントエンドREADMEと共通のものをリンク）
- ER図: （同上）
- DB設計書（Notion）: https://app.notion.com/p/388f9a11acb3807fabf0f09442f7fd06?source=copy_link
- API設計（OpenAPI）: https://gist.github.com/Atsushi-iwaguchi/743ad8a1ade213c17941e37964e3d500

## セットアップ手順

### 必要環境

- Docker / Docker Compose

### 認証情報

本アプリはRailsのcredentials機能で管理する`secret_key_base`をJWTの署名鍵として利用しています。
`master.key`はセキュリティ上リポジトリに含まれていないため、ローカルで動作確認する場合は以下の手順で新規に生成してください。

```bash
docker compose run web bin/rails credentials:edit
```

上記コマンドを実行すると新しい`master.key`と`credentials.yml.enc`が自動生成され、アプリが起動できるようになります（追加で設定する項目はありません）。

なお、本アプリはS3へのアクセスにIAMロールを利用しており、AWSの認証情報をcredentialsやコード内に直接保持していません。

ローカル環境を構築せずに動作を確認したい場合は、以下のデモ環境もご利用いただけます。

アプリURL: https://sailnote-app.com
