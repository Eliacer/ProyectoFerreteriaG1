<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">
  
  <!-- Trigger the modal with a button -->
  <center><button type="button" class="btn btn-default btn-lg" data-toggle="modal" data-target="#Modal">Registrar</button></center>

  <!-- Modal -->
  <div class="modal fade" id="Modal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4><span class="glyphicon glyphicon-lock"></span> Registrar</h4>
        </div>
        <div class="modal-body" style="padding:40px 50px;">
            
        </div>
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
          
        </div>
      </div>
      
    </div>
  </div> 
</div>

<%@include file="WEB-INF/jspf/botton.jspf" %>