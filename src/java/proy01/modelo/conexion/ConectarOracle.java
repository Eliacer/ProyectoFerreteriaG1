/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proy01.modelo.conexion;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Eliacer Fernandez
 */
public class ConectarOracle {
    
    public  static Connection conectar()
    {
        Connection conn = null;
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "ferreteria_daniel", "fernandez");
        } catch (Exception e) {
            e.printStackTrace();
        }        
        
        return conn;
    }
    
}
