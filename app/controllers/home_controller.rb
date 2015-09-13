class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    #oauth_retrive

    if current_user.team.nil?
      if current_user.school.nil?
        redirect_to schools_url, notice: "请选择所在学校"
      elsif !current_user.has_role?(:admin)
        redirect_to school_teams_url(current_user.school), notice: "请选择所在班级"
      end
    end
  end

  private
  def oauth_retrive
    user = current_user
    if not user.blank?
      authentication = user.authentications.first
      if not authentication.blank?
        access_token = authentication.access_token

        client = Weibo2::Client.new
        client.auth_code.authorize_url(:response_type => "token")
        client = Weibo2::Client.from_hash(:access_token => access_token, :expires_in => 86400)
        #response = client.users.show(:uid=>authentication.uid)
        
        begin
          #response = client.statuses.update('client test')
          #set_flash_message(:notice, 'Post success!')
        rescue Exception => e
          #set_flash_message(:alert, e)
        end

      end
    end
  end
end
