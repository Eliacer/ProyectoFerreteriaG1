
<%@include file="WEB-INF/jspf/top.jspf" %>
<div class="container">
    <div class="row"></div>
    <div class="col-md-4"></div>
    <div class="col-md-4">
        <h3 align="center">Registrar Ubicacion</h3>
        <br>
        <form class="form-horizontal" action="Ubicacion.jsp">
            <div class="form-group">
                <div class="input-group">
                        <input type="text" class="form-control" placeholder="nombre de la ubicaci&oacute;n" name="ubicacion">
                        <span class="input-group-btn">
                          <button type="submit" class="btn btn-primary">Agregar</button>
                        </span>
                </div><!-- /input-group -->
            </div>          
        </form>
    </div>
    <div class="col-md-4"></div>
</div>
<%@include file="WEB-INF/jspf/botton.jspf" %>