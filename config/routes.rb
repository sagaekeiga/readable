class WebDomainConstraint
  # Review Appsでは毎回ドメインが変更されるのでドメイン制約をつけない
  def self.matches?(request)
    ENV['REVIEW_APP'].present? || request.host == (ENV['WEB_DOMAIN'])
  end
end

class AdminDomainConstraint
  # Review Appsでは毎回ドメインが変更されるのでドメイン制約をつけない
  def self.matches?(request)
    ENV['REVIEW_APP'].present? || request.host == (ENV['ADMIN_DOMAIN'])
  end
end

Rails.application.routes.draw do
  require 'sidekiq/web'
  #
  # webサービス用のドメイン
  #
  constraints(WebDomainConstraint) do
    root to: 'welcome#index'
    devise_for :users, path: 'users', controllers: {
      registrations: 'users/registrations',
      confirmations: 'users/confirmations',
      sessions: 'users/sessions'
    }
    namespace :users do
      resources :items
    end
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  end
  #
  # 管理者のドメイン
  #
  constraints(AdminDomainConstraint) do
  end
end
