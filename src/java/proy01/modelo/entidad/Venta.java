package proy01.modelo.entidad;

public class Venta {


     private String id_venta;
     private String id_usuario;
     private String id_cliente;
     private String id_formaPago;
     private String id_configuracion;
     private String numComprobante;
     private String fechaventa;
     private String descripcion;
     private String idTipoCliente;
     private String serie;
     private String estado;
     
     private String dcto;

    public Venta() {
    }

    public String getId_venta() {
        return id_venta;
    }

    public String getSerie() {
        return serie;
    }

    public void setSerie(String serie) {
        this.serie = serie;
    }
    
    public void setId_venta(String id_venta) {
        this.id_venta = id_venta;
    }

    public String getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(String id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getId_cliente() {
        return id_cliente;
    }

    public void setId_cliente(String id_cliente) {
        this.id_cliente = id_cliente;
    }

    public String getId_formaPago() {
        return id_formaPago;
    }

    public void setId_formaPago(String id_formaPago) {
        this.id_formaPago = id_formaPago;
    }

    public String getId_configuracion() {
        return id_configuracion;
    }

    public void setId_configuracion(String id_configuracion) {
        this.id_configuracion = id_configuracion;
    }

    public String getNumComprobante() {
        return numComprobante;
    }

    public void setNumComprobante(String numComprobante) {
        this.numComprobante = numComprobante;
    }

    public String getFechaventa() {
        return fechaventa;
    }

    public void setFechaventa(String fechaventa) {
        this.fechaventa = fechaventa;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
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

    public String getDcto() {
        return dcto;
    }

    public void setDcto(String dcto) {
        this.dcto = dcto;
    }

    
    
}


