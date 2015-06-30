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
import proy01.modelo.dao.CompraDao;
import proy01.modelo.daoImpl.CompraDaoImpl;
import proy01.modelo.entidad.Compra;

/**
 *
 * @author Eliacer Fernandez
 */
public class Compras extends HttpServlet {

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
        
        String num_comp=request.getParameter("num_comp");
        
        HttpSession session1 = request.getSession();
        String id_compra=(String)session1.getAttribute("id_compra");
        String id_proveedor=(String)session1.getAttribute("id_proveedor");
        String num_comprobante=(String)session1.getAttribute("num_comprobante");
        
        Compra compra = new Compra();
        CompraDao cd = new CompraDaoImpl();
        
        if (!num_comp.equals("")) {
            
            compra=cd.ListarCompra(num_comp);
            
            HttpSession session = request.getSession();
            session.setAttribute("id_compra", compra.getId_compra());
            session.setAttribute("id_proveedor", compra.getId_proveedor());
            session.setAttribute("num_comprobante", compra.getNumComprobante());
            
            //request.setAttribute("id_compra", compra.getId_compra());
            request.getRequestDispatcher("Compra_detalle.jsp").forward(request, response);
            
            
        } else {
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
