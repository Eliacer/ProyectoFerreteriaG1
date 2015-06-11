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
public class Rep_ventas {
    
    private String id_venta;
    private String nombre_cliente;
    private String nombre_forma_pago;
    private String nombre_tipo_moneda;
    private String nombre_comprobante;
    private String fecha_compra;
    private String nombre_usuario;
    private String fecha_venta;
    private String num_com;

    public Rep_ventas() {
    }

    public String getId_venta() {
        return id_venta;
    }

    public void setId_venta(String id_venta) {
        this.id_venta = id_venta;
    }

    

    public String getNombre_cliente() {
        return nombre_cliente;
    }

    public void setNombre_cliente(String nombre_cliente) {
        this.nombre_cliente = nombre_cliente;
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

    public String getFecha_venta() {
        return fecha_venta;
    }

    public void setFecha_venta(String fecha_venta) {
        this.fecha_venta = fecha_venta;
    }

    public String getNum_com() {
        return num_com;
    }

    public void setNum_com(String num_com) {
        this.num_com = num_com;
    }

    
    
    
    
}
