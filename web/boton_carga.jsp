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
    <style>
        .row-fluid .span12 { width: 100%; *width:99.94680851063829%; margin-left: 0; }
        
        .rw-D {
  background: #fff;padding:20px;
}

@media (max-width: 900px) {
.rw-D >[class*="span"]{ width:100%; margin-left:0px}
.home-lnk {padding: 0px 10px;}
.home-lnk span {font-size: 12px;}
}

@media (max-width: 540px) {
.rw-D >[class*="span"]>[class*="span"]{ width:100%; margin-left:0px}
.md-announcement-links a {
  line-height: 16px;
  padding: 4px 10px;
  font-size: 14px;
  width:100%;
  padding: 20px 30px;
  border-bottom: 1px solid #fff;
}
.liner{ border-top: 1px solid #c0bfd1;padding-bottom: 50px !important;}

.circle-icon-especial {
  width: 70px;
  height: 70px;
  -moz-border-radius: 50%;
  -webkit-border-radius: 50%;
  border-radius: 50%;
  border: 16px solid #c9c7d2;
  margin: auto;
  -o-transition: all 750ms;
  -moz-transition: all 750ms;
  -webkit-transition: all 750ms;
  transition: all 750ms;
}

.md-extra-links a{ padding-top:20px;}
.md-extra-links a span{ width:100%; text-align:center; padding-top:10px;font-family: 'open_sanscondensed_bold'; font-size:21px; color:#939297; line-height:24px;}
.md-extra-links a:hover span{ color:#000;}
.md-extra-links a:hover .circle-icon-especial {
  width: 70px;
  height: 70px;
  -moz-border-radius: 50%;
  -webkit-border-radius: 50%;
  border-radius: 50%;
  border: 16px solid #ec0000;
  margin: auto;
  -o-transition: all 750ms;
  -moz-transition: all 750ms;
  -webkit-transition: all 750ms;
  transition: all 750ms;
}

.row-fluid .span3 { width: 23.404255319148934%; *width:23.351063829787233%;}


.md-extra-links a{ padding-top:20px;}
.md-extra-links a span{ width:100%; text-align:center; padding-top:10px;font-family: 'open_sanscondensed_bold'; font-size:21px; color:#939297; line-height:24px;}
.md-extra-links a:hover span{ color:#000;}
.md-extra-links a:hover .circle-icon-especial {
  width: 70px;
  height: 70px;
  -moz-border-radius: 50%;
  -webkit-border-radius: 50%;
  border-radius: 50%;
  border: 16px solid #ec0000;
  margin: auto;
  -o-transition: all 750ms;
  -moz-transition: all 750ms;
  -webkit-transition: all 750ms;
  transition: all 750ms;
}
.md-extra-links .seguro-salud{ background:url(recursos/img/arca.png) no-repeat center center; width:100%; height:100%; z-index:1;}
.md-extra-links a:hover  .seguro-salud{ background:url(../img/seguro-salud2.png) no-repeat center center; width:100%; height:100%; z-index:1;}
.md-extra-links .experiences-pronabec{ background:url(../img/experiences-pronabec.png) no-repeat center center; width:100%; height:100%; z-index:1;}
.md-extra-links a:hover  .experiences-pronabec{ background:url(../img/experiences-pronabec2.png) no-repeat center center; width:100%; height:100%; z-index:1;}
.md-extra-links .convocatorias{ background:url(../img/convocatorias.png) no-repeat center center; width:100%; height:100%; z-index:1;}
.md-extra-links a:hover  .convocatorias{ background:url(../img/convocatorias2.png) no-repeat center center; width:100%; height:100%; z-index:1;}
.md-extra-links .subvenciones{ background:url(../img/subvenciones.png) no-repeat center center; width:100%; height:100%; z-index:1;}
.md-extra-links a:hover  .subvenciones{ background:url(../img/subvenciones2.png) no-repeat center center; width:100%; height:100%; z-index:1;}

    </style>
    
    <div class="span12 rw-D liner">
			                <div class="span12 md-extra-links">
                    <a href="http://www.pronabec.gob.pe/subvenciones.php" class="span3 relative">
                        <div class="circle-icon-especial">
                            <div class="absolute subvenciones">
                            </div>
                        </div>
                        <span class="span12">
                            SUBVENCIONES
                        </span>
                    </a>
                    <a href="http://www.pronabec.gob.pe/2015_guia_sistema_salud.php" class="span3 relative">
                        <div class="circle-icon-especial ">
                            <div class="absolute seguro-salud">
                            </div>
                        </div>
                        <span class="span12">
                            SEGURO INTEGRAL DE SALUD
                        </span>
                    </a>
                    <a href="http://www.pronabec.gob.pe/experiencias_pronabec.php" class="span3 relative">
                        <div class="circle-icon-especial">
                            <div class="absolute experiences-pronabec">
                            </div>
                        </div>
                        <span class="span12">
                            EXPERIENCIAS PRONABEC
                        </span>
                    </a>
                    <a href="http://www.pronabec.gob.pe/convocatorias.php" class="span3 relative">
                        <div class="circle-icon-especial">
                            <div class="absolute convocatorias">
                            </div>
                        </div>
                        <span class="span12">
                            CONVOCATORIAS DE PERSONAL
                        </span>
                    </a>
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
 