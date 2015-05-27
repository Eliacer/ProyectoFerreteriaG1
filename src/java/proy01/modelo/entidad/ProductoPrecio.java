package proy01.modelo.entidad;

public class ProductoPrecio {


     private String id_producto;
     private Double precio_publico;
     private Double precio_mayor;
     private Double precio_credito;

    public ProductoPrecio() {
    }

    public String getId_producto() {
        return id_producto;
    }

    public void setId_producto(String id_producto) {
        this.id_producto = id_producto;
    }

    public Double getPrecio_publico() {
        return precio_publico;
    }

    public void setPrecio_publico(Double precio_publico) {
        this.precio_publico = precio_publico;
    }

    public Double getPrecio_mayor() {
        return precio_mayor;
    }

    public void setPrecio_mayor(Double precio_mayor) {
        this.precio_mayor = precio_mayor;
    }

    public Double getPrecio_credito() {
        return precio_credito;
    }

    public void setPrecio_credito(Double precio_credito) {
        this.precio_credito = precio_credito;
    }
    
    
}


