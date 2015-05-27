package proy01.modelo.entidad;

public class DetalleCompra {

     private String id_compra;
     private String id_producto;
     private String id_unidad;
     private Integer cantMayor;
     private Integer cantMenor;
     private Double costoMayor;
     private Double costoUnidad;

    public DetalleCompra() {
    }

    public String getId_compra() {
        return id_compra;
    }

    public void setId_compra(String id_compra) {
        this.id_compra = id_compra;
    }

    public String getId_producto() {
        return id_producto;
    }

    public void setId_producto(String id_producto) {
        this.id_producto = id_producto;
    }

    public String getId_unidad() {
        return id_unidad;
    }

    public void setId_unidad(String id_unidad) {
        this.id_unidad = id_unidad;
    }

    public Integer getCantMayor() {
        return cantMayor;
    }

    public void setCantMayor(Integer cantMayor) {
        this.cantMayor = cantMayor;
    }

    public Integer getCantMenor() {
        return cantMenor;
    }

    public void setCantMenor(Integer cantMenor) {
        this.cantMenor = cantMenor;
    }

    public Double getCostoMayor() {
        return costoMayor;
    }

    public void setCostoMayor(Double costoMayor) {
        this.costoMayor = costoMayor;
    }

    public Double getCostoUnidad() {
        return costoUnidad;
    }

    public void setCostoUnidad(Double costoUnidad) {
        this.costoUnidad = costoUnidad;
    }
    
}


