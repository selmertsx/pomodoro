# pomodoro
## 自分のためのコマンド集

```
# nginxの設定reload
docker exec -it pomodoro-web /usr/bin/openresty -s reload
```

```
# dockerでrailsコマンドを実行する
docker-compose run app rails db:migrate
```

## Trello連携の動作確認