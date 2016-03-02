class ComentarioController < ApplicationController
  def index
  end

  def creat
  	@fecha=Time.new
  	@coment=Comentario.new
  	
  	if paramsdata[:nick]==nil
  		@idUsuario=session[:IdUsers].to_s
        @usuario=Usuario.find_by(id:@idUsuario)
  		@coment.nombre=@usuario.nombre
  	else
  		@coment.nombre=paramsdata[:nick]
  	end

  	@coment.comentario=paramsdata[:descripcion]
  	@coment.fecha=@fecha
  	@coment.padre=paramsdata[:padre].to_i
  	@coment.tipo=paramsdata[:tipo].to_i
  	@coment.articulo_id=session[:idarticulo]
  	if @coment.save()
  		redirect_to :controller=> :articulo, :action=>:public,:id => session[:idarticulo]
  	else
  		redirect_to :controller=> :articulo, :action=>:public,:id => session[:idarticulo]
    end
   end

	def Listall
		@idArticulo=params[:id]
		@coment=Comentario.where(articulo_id:@idArticulo)
	end
  def paramsdata
  	params.require(:datacoment).permit(:nick,:descripcion,:padre,:tipo)
  end
end
