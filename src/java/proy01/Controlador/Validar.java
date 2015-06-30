/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.Controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import proy01.modelo.dao.UsuarioDao;
import proy01.modelo.daoImpl.UsuarioDaoImpl;
import proy01.modelo.entidad.Usuario;

/**
 *
 * @author Eliacer Fernandez
 */
public class Validar extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String id_usuario="";
        String usuario=request.getParameter("usuario");
        String password=request.getParameter("password");
        
        
        HttpSession session1 = request.getSession();
        String id=(String)session1.getAttribute("id_usuario");
//        String user=(String)session1.getAttribute("usuario");
//        String pass=(String)session1.getAttribute("password");
        
        String mensaje;
        Usuario u = new Usuario();
        UsuarioDao dao = new UsuarioDaoImpl();
        
        if (dao.validarusuario(usuario, password)!=null) {
            
            u=dao.ObtenerUsuario(usuario, password);
//            id_usuario=u.getIdUsuario();//es prueba de que si envia...
            
            //enviando id en sesion...
            HttpSession session = request.getSession();
            session.setAttribute("id_usuario", u.getIdUsuario());
//            session.setAttribute("usuario", u.getLogin());
//            session.setAttribute("password", u.getPassword());
            
            
                //request.getRequestDispatcher("bienvenida.jsp?id_usuario="+id_usuario).forward(request, response);
//                request.setAttribute("Usuario", dao.ObtenerUsuario(usuario, password));
//                request.setAttribute("id_usuario", id_usuario);
                request.getRequestDispatcher("bienvenida.jsp").forward(request, response);
        } else {
            mensaje="Usuario o password incorrecto...";
            request.getRequestDispatcher("Login.jsp?mensaje="+mensaje).forward(request, response);
        }
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
