package proy01.modelo.entidad;

public class KardexProducto {


     private String fecha;
     private String movimiento;
     private String producto;
     private int cantidad;
     private String und;
     private String comprobante;
     private String num_comp;
     private String prov_cliente;
     

    public KardexProducto() {
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getMovimiento() {
        return movimiento;
    }

    public void setMovimiento(String movimiento) {
        this.movimiento = movimiento;
    }

    public String getProducto() {
        return producto;
    }

    public void setProducto(String producto) {
        this.producto = producto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public String getUnd() {
        return und;
    }

    public void setUnd(String und) {
        this.und = und;
    }

    public String getComprobante() {
        return comprobante;
    }

    public void setComprobante(String comprobante) {
        this.comprobante = comprobante;
    }

    public String getNum_comp() {
        return num_comp;
    }

    public void setNum_comp(String num_comp) {
        this.num_comp = num_comp;
    }

    public String getProv_cliente() {
        return prov_cliente;
    }

    public void setProv_cliente(String prov_cliente) {
        this.prov_cliente = prov_cliente;
    }

    
}


