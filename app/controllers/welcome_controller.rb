class WelcomeController < ApplicationController
  def index
  	if existUser
  		 redirect_to :controller=> :articulo, :action=>:index
  	else
  	end
  end
  def articulos
    @articulos=Articulo.all
  end

  def about
    
  end

  def contacto
    
  end
  def creat
  	
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
