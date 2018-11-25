# README

Ruby 2.5.3

Rails 5.1

sqlite3


rake db:drop db:create db:migrate

rake db:seed

rails s


Спеки: bundle exec rspec

Задачи на отправку сообщений: app/jobs/send_message_job.rb

Очереди: Sidekiq + Redis

Экшен new в SendController добавляет в очередь новую задачу



Features (HTTPie client):

Пройти аутентификацию одним из пользователей из модели User :3000/auth/login name=<имя пользователя с мессенджере> password=<пароль (у всех в seeds.rb "1111")>

Отправить запрос на сообщение :3000/send user_id=<ид> text=<сообщение> date=<дата например число.месяц.год hh:MM:ss> \
\> Authorization:'<токен, полученный при аутентификации>'

