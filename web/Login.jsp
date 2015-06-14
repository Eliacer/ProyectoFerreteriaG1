
<!DOCTYPE html>  
    <title>Login ferreteria</title>
    <link rel="shortcut icon" type="image/x-icon" href="recursos/img/favicon.ico"/>
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="css/estilo.css">
    <link rel="stylesheet" href="css/estilo_1.css">
	
  </head>
  <body>
      
<%
    String mensaje=request.getParameter("mensaje");mensaje = mensaje==null?"":mensaje;
            
%>
      <header>   
        <div class="container">
            <div class="fondo">
                <div class="row">          
                    <div class="col-md-3">
                        <div class="logo">
                            <a href="Inicio.jsp"><img src="recursos/img/logo_arca.png" class="img-responsive" alt="Imagen responsive"></a>                        
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="text1">
                            <p>Ferreter&iacute;a "El Arca"</p>
                        </div>
                        <div class="text2">
                            <p>Propietario: Daniel Rios San Miguel</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="text3">
                            <h3>Encuentranos en:</h3>     
                        </div>                      
                    </div>
                </div>
                <br>
            </div>
        </div>
    </header>    
    <article>
        <div class="container">
        <div class="container well" id="sha">
            <div class="row">
                <div class="col-md-12">
                     <h2 class=" form-signin-heading"><center><strong>Ingresa Aqu&iacute;</strong></center></h2>
                     <br>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <form class="" action="control" method="post">
                    <div class="form-group">
                        <%/*<div class="input-group">
                               <%/*<span class="input-group-addon">@</span>*/%>
                               <input type="Usuario" class="form-control" placeholder="Usuario" name="usuario" required autofocus>
                        <%/*</div>*/%>
                    </div>
                    <div class="form-group">
                        <input type="password" class="form-control" placeholder="Contrase&ntilde;a" name="password" required>
                    </div>
                    <button class="btn btn-lg btn-primary btn-block" type="submit">
                    <strong>Iniciar seci&oacute;n</strong>
                    </button>
                </form>
                
                </div>
            </div>          
        </div>
            <div class="row">
                <div class="col-md-12" id="aler">
                    <br>
                    <%
                        if(!mensaje.equals("")){
                    %>
                    <div class="alert alert-danger"><%=mensaje%></div> 
                    <%}%>
                </div>
            </div> 
        </div>
    </article>  
      <div class="container">
        <div class="col-md-12"> 
            <footer>
                &copy; Derechos reservador por los autores: Eliacer, Mirian, Edgar y Daniel  
            </footer>
        </div>
      </div>
      </div>
</body>
    <script src="jquery/jquery-1.11.2.min.js"></script>
    <script src="bootstrap/js/bootstrap.js"></script>
</html>