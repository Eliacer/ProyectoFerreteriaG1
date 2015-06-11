<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">
  
  <!-- Trigger the modal with a button -->
  <center><button type="button" class="btn btn-default btn-lg" id="myBtn">Registrar</button></center>

  <!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4><span class="glyphicon glyphicon-lock"></span> Registrar</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
            <form role="form" action="RegistrarPersona.jsp" method="post">
          <div class="col-xs-4">
            <a href=""><button type="submit" class="btn btn-primary "><span class="glyphicon glyphicon-user"></span> Usuario</button></a>
          </div>
          <div class="col-xs-4">
            <a href=""><button type="submit" class="btn btn-success "><span class="glyphicon glyphicon-user"></span> General</button></a>
          </div>
          <div class="col-xs-4">
            <a href=""><button type="submit" class="btn btn-dangerus "><span class="glyphicon glyphicon-user"></span> Cliente</button></a>
          </div>
              
          </form>
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
          
        </div>
      </div>
      
    </div>
  </div> 
</div>

<%@include file="WEB-INF/jspf/botton.jspf" %>