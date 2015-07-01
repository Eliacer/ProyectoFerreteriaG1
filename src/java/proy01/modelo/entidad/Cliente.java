package proy01.modelo.entidad;

public class Cliente  implements java.io.Serializable {


     private String idCliente="";
     private String idTipoCliente="";
     private String estado="";

    public Cliente() {
    }

    public String getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(String idCliente) {
        this.idCliente = idCliente;
    }

    public String getIdTipoCliente() {
        return idTipoCliente;
    }

    public void setIdTipoCliente(String idTipoCliente) {
        this.idTipoCliente = idTipoCliente;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
 
}


