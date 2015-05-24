package proy01.modelo.entidad;
// Generated 07/05/2015 07:26:51 PM by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * Persona generated by hbm2java
 */
public class Persona  implements java.io.Serializable {


     private String idPersona;
     private TipoDocumento tipoDocumento;
     private String id_tipoDocum;
     private String nombres;
     private String apellidos;
     private String genero;
     private String fechaNac1;
     private Date fechaNac;
     private String telefono;
     private String numeroDoc;
     private String direccion;
     private String estado;
     private Cliente cliente;
     private Usuario usuario;
     private Proveedor proveedor;

    public Persona() {
    }

	
    public Persona(String idPersona, String nombres) {
        this.idPersona = idPersona;
        this.nombres = nombres;
    }

    public Persona(String idPersona, TipoDocumento tipoDocumento, String id_tipoDocum, String nombres, String apellidos, String genero, Date fechaNac, String telefono, String numeroDoc, String direccion, String estado, Cliente cliente, Usuario usuario, Proveedor proveedor) {
        this.idPersona = idPersona;
        this.tipoDocumento = tipoDocumento;
        this.id_tipoDocum = id_tipoDocum;
        this.nombres = nombres;
        this.apellidos = apellidos;
        this.genero = genero;
        this.fechaNac = fechaNac;
        this.telefono = telefono;
        this.numeroDoc = numeroDoc;
        this.direccion = direccion;
        this.estado = estado;
        this.cliente = cliente;
        this.usuario = usuario;
        this.proveedor = proveedor;
    }

    public String getIdPersona() {
        return idPersona;
    }

    public void setIdPersona(String idPersona) {
        this.idPersona = idPersona;
    }

    public TipoDocumento getTipoDocumento() {
        return tipoDocumento;
    }

    public void setTipoDocumento(TipoDocumento tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }

    public String getId_tipoDocum() {
        return id_tipoDocum;
    }

    public void setId_tipoDocum(String id_tipoDocum) {
        this.id_tipoDocum = id_tipoDocum;
    }

    public String getNombres() {
        return nombres;
    }

    public void setNombres(String nombres) {
        this.nombres = nombres;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getFechaNac1() {
        return fechaNac1;
    }

    public void setFechaNac1(String fechaNac1) {
        this.fechaNac1 = fechaNac1;
    }

    public Date getFechaNac() {
        return fechaNac;
    }

    public void setFechaNac(Date fechaNac) {
        this.fechaNac = fechaNac;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getNumeroDoc() {
        return numeroDoc;
    }

    public void setNumeroDoc(String numeroDoc) {
        this.numeroDoc = numeroDoc;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public Proveedor getProveedor() {
        return proveedor;
    }

    public void setProveedor(Proveedor proveedor) {
        this.proveedor = proveedor;
    }
    
   
    
}


