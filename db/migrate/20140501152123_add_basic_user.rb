class AddBasicUser < ActiveRecord::Migration
  def change
    user = User.create! :name=>'oxcafe', :email=>'oxcafe@126.com', :password=>'11111111'
    user.add_role :admin
    user.save
    user = User.create! :name=>'basicme', :email=>'basicme@sina.cn', :password=>'11111111'
    user.add_role :user
    user.save
    User.create! :name=>'test', :email=>'test@sina.cn', :password=>'11111111'
    user = User.create! :name=>'test1', :email=>'test1@sina.cn', :password=>'11111111'
    user .add_role :guest
    user.save
  end
end
