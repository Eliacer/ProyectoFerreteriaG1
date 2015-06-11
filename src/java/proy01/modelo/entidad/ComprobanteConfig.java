package proy01.modelo.entidad;

public class ComprobanteConfig  implements java.io.Serializable {


     private String idConfiguracion;
     private String idComprobante;
     private String Serie;
     private String Contaximo;
     private String NumLimite;
     private String MaqRegistradora;
     private String NumeroAutorizado;
     private String Fechareg;
     private String Estado;
     

    public ComprobanteConfig() {
    }

    public String getIdConfiguracion() {
        return idConfiguracion;
    }

    public void setIdConfiguracion(String idConfiguracion) {
        this.idConfiguracion = idConfiguracion;
    }

    public String getIdComprobante() {
        return idComprobante;
    }

    public void setIdComprobante(String idComprobante) {
        this.idComprobante = idComprobante;
    }

    public String getSerie() {
        return Serie;
    }

    public void setSerie(String Serie) {
        this.Serie = Serie;
    }

    public String getContaximo() {
        return Contaximo;
    }

    public void setContaximo(String Contaximo) {
        this.Contaximo = Contaximo;
    }

    public String getNumLimite() {
        return NumLimite;
    }

    public void setNumLimite(String NumLimite) {
        this.NumLimite = NumLimite;
    }

    public String getMaqRegistradora() {
        return MaqRegistradora;
    }

    public void setMaqRegistradora(String MaqRegistradora) {
        this.MaqRegistradora = MaqRegistradora;
    }

    public String getNumeroAutorizado() {
        return NumeroAutorizado;
    }

    public void setNumeroAutorizado(String NumeroAutorizado) {
        this.NumeroAutorizado = NumeroAutorizado;
    }

    public String getFechareg() {
        return Fechareg;
    }

    public void setFechareg(String Fechareg) {
        this.Fechareg = Fechareg;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

    
    
}


