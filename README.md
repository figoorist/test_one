# README

Ruby 2.5.3
Rails 5.1
sqlite3

Спеки: bundle exec rspec

Задачи на отправку сообщений: app/jobs/send_message_job.rb
Очереди: Sidekiq + Redis
Экшен new в SendController добавляет в очередь новую задачу

rake db:drop db:create db:migrate

rake db:seed

rails s

Features:

Отправить запрос на сообщение :3000/send user_id=<ид> text=<сообщение> date=<дата например число.месяц.год>

