package proy01.modelo.entidad;
// Generated 07/05/2015 07:26:51 PM by Hibernate Tools 4.3.1


import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;

/**
 * DetalleVenta generated by hbm2java
 */
public class DetalleVenta  implements java.io.Serializable {


     private DetalleVentaId id;
     private Producto producto;
     private Venta venta;
     private BigDecimal cantidad;
     private Double precioUnitario;
     private Set detalleDevolucions = new HashSet(0);

    public DetalleVenta() {
    }

	
    public DetalleVenta(DetalleVentaId id, Producto producto, Venta venta) {
        this.id = id;
        this.producto = producto;
        this.venta = venta;
    }
    public DetalleVenta(DetalleVentaId id, Producto producto, Venta venta, BigDecimal cantidad, Double precioUnitario, Set detalleDevolucions) {
       this.id = id;
       this.producto = producto;
       this.venta = venta;
       this.cantidad = cantidad;
       this.precioUnitario = precioUnitario;
       this.detalleDevolucions = detalleDevolucions;
    }
   
    public DetalleVentaId getId() {
        return this.id;
    }
    
    public void setId(DetalleVentaId id) {
        this.id = id;
    }
    public Producto getProducto() {
        return this.producto;
    }
    
    public void setProducto(Producto producto) {
        this.producto = producto;
    }
    public Venta getVenta() {
        return this.venta;
    }
    
    public void setVenta(Venta venta) {
        this.venta = venta;
    }
    public BigDecimal getCantidad() {
        return this.cantidad;
    }
    
    public void setCantidad(BigDecimal cantidad) {
        this.cantidad = cantidad;
    }
    public Double getPrecioUnitario() {
        return this.precioUnitario;
    }
    
    public void setPrecioUnitario(Double precioUnitario) {
        this.precioUnitario = precioUnitario;
    }
    public Set getDetalleDevolucions() {
        return this.detalleDevolucions;
    }
    
    public void setDetalleDevolucions(Set detalleDevolucions) {
        this.detalleDevolucions = detalleDevolucions;
    }




}


