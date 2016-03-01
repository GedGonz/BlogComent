require 'digest/md5'
require 'base64'
class LoginController < ApplicationController

  def index
  end

  def loginIn
  end

  def new
  	Usuario.new
  end
  def creat
    
    @user=Usuario.new
    @user.nombre=paramregist[:name]
    @user.apellido=paramregist[:lasname]
    @user.username=paramregist[:username]
    @user.password="{MD5}" + Base64.encode64(Digest::MD5.digest(paramregist[:password]))
    @repeatpass=paramregist[:repetatp]

    if @user.save()
        redirect_to :controller=> :login,:action => :loginIn
    else
        render "new"
    end
  end


  def access

    @password="{MD5}" + Base64.encode64(Digest::MD5.digest(paramacces[:password]))
    @user=Usuario.find_by(username:paramacces[:username],password:@password)
    
      if(@user)
          session[:IdUsers]=@user.id;
          redirect_to :controller=> :articulo,:action => :index
      else
          render "new"
      end
  end

  def paramregist
      params.require(:datauser).permit(:name, :lasname, :username,:password,:repetatp)
  end

  def paramacces
      params.require(:logins).permit(:username,:password)
  end

end
