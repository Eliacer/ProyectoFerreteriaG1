package proy01.modelo.entidad;

public class Producto {


     private String idProducto;
     private String codigo;
     private String nombre;
     private String IdUndMedida;
     private Double concentracion;
     private String color;
     private Double costo;
     private int stock;
     private String fecha_reg;
     private String id_categoria;
     private String id_marca;
     private String id_ubicacion;
     private String descripcion;

    public Producto() {
    }

    public String getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(String idProducto) {
        this.idProducto = idProducto;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getIdUndMedida() {
        return IdUndMedida;
    }

    public void setIdUndMedida(String IdUndMedida) {
        this.IdUndMedida = IdUndMedida;
    }

    public Double getConcentracion() {
        return concentracion;
    }

    public void setConcentracion(Double concentracion) {
        this.concentracion = concentracion;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public Double getCosto() {
        return costo;
    }

    public void setCosto(Double costo) {
        this.costo = costo;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getFecha_reg() {
        return fecha_reg;
    }

    public void setFecha_reg(String fecha_reg) {
        this.fecha_reg = fecha_reg;
    }

    public String getId_categoria() {
        return id_categoria;
    }

    public void setId_categoria(String id_categoria) {
        this.id_categoria = id_categoria;
    }

    public String getId_marca() {
        return id_marca;
    }

    public void setId_marca(String id_marca) {
        this.id_marca = id_marca;
    }

    public String getId_ubicacion() {
        return id_ubicacion;
    }

    public void setId_ubicacion(String id_ubicacion) {
        this.id_ubicacion = id_ubicacion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
    
}


