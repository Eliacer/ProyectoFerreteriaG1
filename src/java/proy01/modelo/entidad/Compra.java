package proy01.modelo.entidad;

public class Compra {


     private String id_compra;
     private String id_usuario;
     private String id_proveedor;
     private String id_formaPago;
     private String id_comprobante;
     private String id_tipoMoneda;
     private String numComprobante;
     private String fechaCompra;
     private String descripcion;
     private String igv;
     private String flete;
     private String precio_fijado;

    public Compra() {
    }

    public String getId_compra() {
        return id_compra;
    }

    public void setId_compra(String id_compra) {
        this.id_compra = id_compra;
    }

    public String getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(String id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getId_proveedor() {
        return id_proveedor;
    }

    public void setId_proveedor(String id_proveedor) {
        this.id_proveedor = id_proveedor;
    }

    public String getId_formaPago() {
        return id_formaPago;
    }

    public void setId_formaPago(String id_formaPago) {
        this.id_formaPago = id_formaPago;
    }

    public String getId_comprobante() {
        return id_comprobante;
    }

    public void setId_comprobante(String id_comprobante) {
        this.id_comprobante = id_comprobante;
    }

    public String getId_tipoMoneda() {
        return id_tipoMoneda;
    }

    public void setId_tipoMoneda(String id_tipoMoneda) {
        this.id_tipoMoneda = id_tipoMoneda;
    }

    public String getNumComprobante() {
        return numComprobante;
    }

    public void setNumComprobante(String numComprobante) {
        this.numComprobante = numComprobante;
    }

    public String getFechaCompra() {
        return fechaCompra;
    }

    public void setFechaCompra(String fechaCompra) {
        this.fechaCompra = fechaCompra;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getIgv() {
        return igv;
    }

    public void setIgv(String igv) {
        this.igv = igv;
    }

    public String getFlete() {
        return flete;
    }

    public void setFlete(String flete) {
        this.flete = flete;
    }

    public String getPrecio_fijado() {
        return precio_fijado;
    }

    public void setPrecio_fijado(String precio_fijado) {
        this.precio_fijado = precio_fijado;
    }
    
    
}


