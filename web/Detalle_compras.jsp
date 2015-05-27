<%@include file="WEB-INF/jspf/top.jspf" %>

<div class="container">
    
    <%
        String num_comp=request.getParameter("num_comp");num_comp = num_comp==null?"":num_comp;
    
    %>
    
<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
        <table class="table table-condensed">
            <tbody>   
                <tr>
                    <td colspan="2"><%=%></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="col-md-2"></div>
</div>
<div class="row">
    <div class="col-md-2"></div>
    <div class="col-md-8">
        <h1></h1>
        <form method="post"> 
            <table class="table table-condensed">
                <tbody>   
                    <tr>
                      <td><lebel class="col-sm-2 control-label">Nombres</lebel></td>
                      <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Nombre" value=""></div></td>
                    </tr>
                    <tr>
                      <td><lebel class="col-sm-2 control-label">Apellidos</lebel></td>
                      <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Apellido" value=""></div></td>
                    </tr>
                    <tr>
                        <td><lebel class="col-sm-2 control-label">Genero</lebel></td>
                        <td><label class="radio-inline">
                            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="option1">Femenino
                            </label>
                        <label class="radio-inline">
                            <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="option2">Masculino
                            </label>
                        </td>
                    </tr>
                    <tr>
                      <td><lebel class="col-sm-2 control-label">Dirección</lebel></td>
                      <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="Dirección" maxlength="9" value=""></div></td>
                    </tr>
                    <tr>
                      <td><lebel class="col-sm-2 control-label">D.N.I</lebel></td>
                      <td><div class="col-sm-15"><input type="text" class="form-control" placeholder="D.N.I" maxlength="8" value=""></div></td>
                    </tr>
                    <tr>
                      <td><lebel class="col-sm-2 control-label">Aula</lebel></td>
                      <td><select class="form-control">
                      <option>Seleccionar</option>
                      <option>A-1</option>
                      <option>A-2</option>
                      <option>A-3</option>
                      </select></td>
                    </tr>
                    <tr>
                      <td><lebel class="col-sm-2 control-label">Fecha_Inicio</lebel></td>
                      <td><div class="col-sm-15"><input type="date" class="form-control"></div></td>
                    </tr>
                    <tr>
                      <td colspan="3" align="center"><input type="submit" name="Submit" class="btn btn-primary" value="Enviar"></td>
                    </tr>
                </tbody>
            </table>
        </form>
    </div>
    <div class="col-md-2"></div>
</div>
</div>

<%@include file="WEB-INF/jspf/botton.jspf" %>