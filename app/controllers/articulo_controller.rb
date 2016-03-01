class ArticuloController < ApplicationController
  def index
  	if existUser

  	else
  		redirect_to :controller=> :login, :action=>:loginIn
  	end
  end
  
  def new
  	if existUser
  		@articulo=Articulo.new
  	else
  		redirect_to :controller=> :login, :action=>:loginIn
  	end
  end

  def creat
  	if existUser
  		@idUsuario=session[:IdUsers].to_s
        @articulo=Articulo.new
        @articulo.titulo=paramregist[:titulo]
        @articulo.descripcion=paramregist[:descripcion]
        @articulo.autor=paramregist[:autor]
        @articulo.fecha=paramregist[:fecha]
        @articulo.usuario_id=@idUsuario

        if @articulo.save
    	    redirect_to :controller=> :articulo, :action=>:index
        else
    	    render "new"
        end
  	else
  		redirect_to :controller=> :login, :action=>:loginIn
  	end
  	
    
  end

  def list
  	if existUser

  	else
  		redirect_to :controller=> :login, :action=>:loginIn
  	end
  end


  def logout
  	if existUser
  		reset_session
  	    redirect_to :controller=> :welcome, :action=>:index
  	else
  		redirect_to :controller=> :login, :action=>:loginIn
  	end
  	
  	
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

  def paramregist
      params.require(:articulo).permit(:titulo, :descripcion, :autor,:fecha)
  end
end
