<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <h1>Boronoes de carga y acordeones</h1>
            
        <div class="panel-group">
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#agregar" aria-expanded="true">
                            <span class="glyphicon glyphicon-user" aria-hidden="true"></span>Agregar Usuario  
                        </a>
                    </h4>
                    
                </div>
                <div id="agregar" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <form id="formulario">
                            <div class="form-group">
                                <label for="nombre">Nombre del usuario</label>
                                <input type="text" name="nombre" class="form-control" id="nombre">
                            </div>
                            <button type="button" id="BotonGuardar" data-loading-text="Guardando..." class="btn btn-primary">Gurdar
                                
                            </button>
                        </form>
                        
                    </div> 
                </div>
            </div>
        
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#agregarcliente" aria-expanded="true">
                            <span class="glyphicon glyphicon-user" aria-hidden="true"></span>Agregar Cliente  
                        </a>
                    </h4>
                    
                </div>
                <div id="agregarcliente" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <form id="formulario">
                            <div class="form-group">
                                <label for="nombre">Nombre del usuario</label>
                                <input type="text" name="nombre" class="form-control" id="nombre">
                            </div>
                            <button type="button" id="BotonGuardar" data-loading-text="Guardando..." class="btn btn-primary">Gurdar
                                
                            </button>
                        </form>
                        
                    </div> 
                </div>
            </div>
            <div class="panel panel-success">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <a data-toggle="collapse" href="#agregarprov" aria-expanded="true">
                            <span class="glyphicon glyphicon-user" aria-hidden="true"></span>Agregar proveedor  
                        </a>
                    </h4>
                    
                </div>
                <div id="agregarprov" class="panel-collapse collapse in">
                    <div class="panel-body">
                        <form id="formulario">
                            <div class="form-group">
                                <label for="nombre">Nombre del usuario</label>
                                <input type="text" name="nombre" class="form-control" id="nombre">
                            </div>
                            <button type="button" id="BotonGuardar" data-loading-text="Guardando..." class="btn btn-primary">Gurdar
                                
                            </button>
                        </form>
                        
                    </div> 
                </div>
            </div>
        </div>
        </div>
        <div class="col-md-3"></div>
    </div>
    
</div>
<div class="container" id="contenedor">
    
</div>

<script type="text/javascript">
    $('#BotonGuardar').on('click',function (){
       var $btn = $(this).button('loading');
       $.ajax({
           type: "POST",
           url: "boton_carga.jsp",
           data: $('#formulario').serialize(),
           success: function (data){
               var nombre=data;
               var alerta = '<div class="alert alert-success" id="alerta">El usuario: <b>'+data+'</b> fue agregado correctamente...</div>';
               $('#contenedor').html(alerta);
               $btn.button('reset');
           }
       });
    });
</script>
    
        
<%@include file="WEB-INF/jspf/botton.jspf" %>           
 