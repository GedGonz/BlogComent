require 'digest/md5'
require 'base64'
class LoginController < ApplicationController

  def index
    if existUser
       redirect_to :controller=> :articulo, :action=>:index
    else
    end
  end

  def loginIn
    if existUser
       redirect_to :controller=> :articulo, :action=>:index
    else
    end
  end

  def new
    if existUser
       redirect_to :controller=> :articulo, :action=>:index
    else
      Usuario.new
    end
  	
  end
  def creat
    if existUser
       redirect_to :controller=> :articulo, :action=>:index
    else
    
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
  end


  def access
    if existUser
       redirect_to :controller=> :articulo, :action=>:index
    else
    
      @password="{MD5}" + Base64.encode64(Digest::MD5.digest(paramacces[:password]))
      @user=Usuario.find_by(username:paramacces[:username],password:@password)
      
        if(@user)
            session[:IdUsers]=@user.id;
            redirect_to :controller=> :articulo,:action => :index
        else
            render "new"
        end
      end
  end

  def paramregist
      params.require(:datauser).permit(:name, :lasname, :username,:password,:repetatp)
  end

  def paramacces
      params.require(:logins).permit(:username,:password)
  end

  def existUser
    @idUsuario=session[:IdUsers].to_s
    @usuario=Usuario.find_by(id:@idUsuario)
  if @usuario
     return true
  else
     return false
  end
    
  end
end
