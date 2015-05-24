package proy01.modelo.entidad;
// Generated 07/05/2015 07:26:51 PM by Hibernate Tools 4.3.1



/**
 * DetalleCompraId generated by hbm2java
 */
public class DetalleCompraId  implements java.io.Serializable {


     private String idCompra;
     private String idProducto;

    public DetalleCompraId() {
    }

    public DetalleCompraId(String idCompra, String idProducto) {
       this.idCompra = idCompra;
       this.idProducto = idProducto;
    }
   
    public String getIdCompra() {
        return this.idCompra;
    }
    
    public void setIdCompra(String idCompra) {
        this.idCompra = idCompra;
    }
    public String getIdProducto() {
        return this.idProducto;
    }
    
    public void setIdProducto(String idProducto) {
        this.idProducto = idProducto;
    }


   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof DetalleCompraId) ) return false;
		 DetalleCompraId castOther = ( DetalleCompraId ) other; 
         
		 return ( (this.getIdCompra()==castOther.getIdCompra()) || ( this.getIdCompra()!=null && castOther.getIdCompra()!=null && this.getIdCompra().equals(castOther.getIdCompra()) ) )
 && ( (this.getIdProducto()==castOther.getIdProducto()) || ( this.getIdProducto()!=null && castOther.getIdProducto()!=null && this.getIdProducto().equals(castOther.getIdProducto()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getIdCompra() == null ? 0 : this.getIdCompra().hashCode() );
         result = 37 * result + ( getIdProducto() == null ? 0 : this.getIdProducto().hashCode() );
         return result;
   }   


}

