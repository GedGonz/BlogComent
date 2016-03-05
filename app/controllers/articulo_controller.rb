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
        uploaded_io = paramregist[:Imag];
       
        Cloudinary.config do |config|
          config.cloud_name = 'gedgonz'
          config.api_key = '817862158519284'
          config.api_secret = 'Yi7Usj78XdZhcpnHzwquG9fvt3E'
          config.cdn_subdomain = true
          config.enhance_image_tag = true
          config.static_image_support = false
        end
  		  @idUsuario=session[:IdUsers].to_s
        @articulo=Articulo.new
        @articulo.titulo=paramregist[:titulo]
        @articulo.descripcion=paramregist[:descripcion]
        @articulo.autor=paramregist[:autor]
        @articulo.fecha=paramregist[:fecha]
        @articulo.usuario_id=@idUsuario
        @articulo.image=uploaded_io.original_filename
        FileUpload(uploaded_io,@articulo.image);
        @data="public/uploads/"+@articulo.image
        puts "xxxxxxxxxxxxxxxxxxxxxxxxx"
        @ruta=Rails.root.join('public', 'uploads', @articulo.image)
        
        cloud= Cloudinary::Uploader.upload(@ruta)
        @articulo.image=cloud['url']
        puts @articulo.image
        
        
        if @articulo.save
          /FileUpload(uploaded_io,@articulo.image);/
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
  		@idUsuario=session[:IdUsers].to_s
  		@articulos=Articulo.where(usuario_id:@idUsuario)
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
      params.require(:articulod).permit(:titulo, :descripcion, :autor,:fecha,:texto,:Imag)
  end

  def paramartic
      params.require(:articulod).permit(:id)
  end

  def public

  	   @idArticulo=params[:id]
       session[:idarticulo]=@idArticulo
  	   @articulos=Articulo.where(id:@idArticulo)
       @html=""
       @agregado=[]
       
       @coment=Comentario.where(articulo_id:@idArticulo)
        iteracion(@coment)  	

  	
  end

  def iteracion(comentario)
    
  / @comntfind=idcomentario/
 
      
   comentario.each do |comnt|

        if @agregado[comnt.id]!=comnt.id
         @valor=subcoment(comnt.id)
        else
           @valor=[]
        end
            
           if @agregado[comnt.id]!=comnt.id || @valor.length>0
              
             @html=@html+"<div class='panel-body'>"
             @html= @html +"<div>"
             if comnt.tipo==0
               @html=@html+"<img class='Imagcoment' src='/assets/iconcoment.png'>"
             else
               @html=@html+"<img class='Imagcoment' src='/assets/iconcoment3.png'>"
             end
             /ComentarioS/

             @html=@html+"<h10 class='textoeslogan1'>"+comnt.nombre+"</h10>"
             @html=@html+"<button id='"+comnt.id.to_s+"' type='submit' onClick='imprimir("+comnt.id.to_s+");' class='btn btn-primary btn-sm'>"
             @html=@html+"<i class='material-icons'>speaker_notes</i></button>"
             @html=@html+"</div>"
             @html=@html+"<span>"+comnt.comentario+"</span><br>"
             @html=@html+"<span>"+comnt.fecha.to_s+"</span>"
             @html=@html+"<div id='formComent"+comnt.id.to_s+"' class='formComent'>"
             @html=@html+"<div class='row'>"
             @html=@html+"<div class='col-md-4'>"
             @html=@html+"<div class='panel panel-default'>"
             @html=@html+"<div class='panel-body'>"
             /Formularios/
             @html=@html+"<form name='datacoment' accept-charset='UTF-8' action='/comentario/creat' method='post'>"
             @html=@html+"<div style='display:none'><input name='utf8' type='hidden' value='&#x2713;' /><input name='authenticity_token' type='hidden' value='drzc0zsFRwBpdz+NllsRFnU9HaM3nOqZAfUl3KpDz74=' /></div>"
             @html=@html+"<div class='form-group'>"
             if session[:IdUsers]
               @html=@html+"<textarea class='materialize-textarea' id='datacoment_descripcion' name='datacoment[descripcion]' placeholder='Comentario'>"
               @html=@html+"</textarea>"
               @html=@html+"<input class='padre' id='padre"+comnt.id.to_s+"' name='datacoment[padre]' type='text' value='"+comnt.id.to_s+"' />"
               @html=@html+"<input class='tipo' id='tipo"+comnt.id.to_s+"' name='datacoment[tipo]' type='text' value='0' />"
             else
               @html=@html+"<input class='form-control' id='padre"+comnt.id.to_s+"' name='datacoment[nick]' type='text' placeholder='Nombre' />"
               @html=@html+"<textarea class='materialize-textarea' id='datacoment_descripcion' name='datacoment[descripcion]' placeholder='Comentario'>"
               @html=@html+"</textarea>"
               @html=@html+"<input class='padre' id='padre"+comnt.id.to_s+"' name='datacoment[padre]' type='text' value='"+comnt.id.to_s+"' />"
               @html=@html+"<input class='tipo' id='tipo"+comnt.id.to_s+"' name='datacoment[tipo]' type='text' value='1' />"
             end
             @html=@html+"</div>"
             @html=@html+"<div class='form-group'>"
             @html=@html+"<button type='submit' class='btn btn-primary btn-sm'>"
             @html=@html+"<i class='material-icons'>send</i>"
             @html=@html+"</button></div></form></div></div></div>"
             @html=@html+"<div class='col-md-4'>"  
             @html=@html+"</div>"
             @html=@html+"<div class='col-md-4'></div></div></div>"

             / @valor.each do |comnto|/
                @agregado[comnt.id]=comnt.id
            /  end/
                /puts "entro en subcoment" /
                @html=@html+"<hr  style='color: blue; background-color: black; width:75%;  text-align: left;'/>"
                iteracion(@valor)

             @html=@html+"</div>"
           end
          
         
   end
  
   end
    
   

  def subcoment(idcomentario)
    @idArticulo=params[:id]
    @subc=Comentario.where(articulo_id:@idArticulo,padre:idcomentario)
  end

  def FileUpload(fileup,filename)
      File.open(Rails.root.join('public', 'uploads', filename), 'wb') do |file|
      file.write(fileup.read)
    end
  end



end
