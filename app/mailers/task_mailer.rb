# app/mailers/task_mailer.rb
class TaskMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def task_created(task)
    @task = task
    @user = task.user
    mail(to: @user.email, subject: 'A new task has been created')
  end

  def task_updated(task)
    @task = task
    @user = task.user
    mail(to: @user.email, subject: 'A task has been updated')
  end
end
