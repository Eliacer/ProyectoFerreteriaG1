/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.entidad;

/**
 *
 * @author Eliacer Fernandez
 */
public class Rep_compras {
    
    private String id_compra;
    private String nombre_proveedor;
    private String nombre_forma_pago;
    private String nombre_tipo_moneda;
    private String nombre_comprobante;
    private String fecha_compra;
    private String nombre_usuario;
    private String direccion_prov;
    private String valor_moneda;
    private String fecha_precio;
    private Double precio_fijado;
    private String igv;
    private String flete;
    private String num_com;

    public Rep_compras() {
    }

    public String getId_compra() {
        return id_compra;
    }

    public String getNum_com() {
        return num_com;
    }

    public void setNum_com(String num_com) {
        this.num_com = num_com;
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
    
    public void setId_compra(String id_compra) {
        this.id_compra = id_compra;
    }
    
    public String getNombre_proveedor() {
        return nombre_proveedor;
    }

    public void setNombre_proveedor(String nombre_proveedor) {
        this.nombre_proveedor = nombre_proveedor;
    }

    public String getNombre_forma_pago() {
        return nombre_forma_pago;
    }

    public void setNombre_forma_pago(String nombre_forma_pago) {
        this.nombre_forma_pago = nombre_forma_pago;
    }

    public String getNombre_tipo_moneda() {
        return nombre_tipo_moneda;
    }

    public void setNombre_tipo_moneda(String nombre_tipo_moneda) {
        this.nombre_tipo_moneda = nombre_tipo_moneda;
    }

    public String getNombre_comprobante() {
        return nombre_comprobante;
    }

    public void setNombre_comprobante(String nombre_comprobante) {
        this.nombre_comprobante = nombre_comprobante;
    }

    public String getFecha_compra() {
        return fecha_compra;
    }

    public void setFecha_compra(String fecha_compra) {
        this.fecha_compra = fecha_compra;
    }

    public String getNombre_usuario() {
        return nombre_usuario;
    }

    public void setNombre_usuario(String nombre_usuario) {
        this.nombre_usuario = nombre_usuario;
    }

    public String getDireccion_prov() {
        return direccion_prov;
    }

    public void setDireccion_prov(String direccion_prov) {
        this.direccion_prov = direccion_prov;
    }

    public String getValor_moneda() {
        return valor_moneda;
    }

    public void setValor_moneda(String valor_moneda) {
        this.valor_moneda = valor_moneda;
    }

    public String getFecha_precio() {
        return fecha_precio;
    }

    public void setFecha_precio(String fecha_precio) {
        this.fecha_precio = fecha_precio;
    }

    public Double getPrecio_fijado() {
        return precio_fijado;
    }

    public void setPrecio_fijado(Double precio_fijado) {
        this.precio_fijado = precio_fijado;
    }
    
    
    
}
