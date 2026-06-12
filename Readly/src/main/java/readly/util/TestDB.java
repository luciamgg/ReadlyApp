package readly.util;

import java.sql.Connection;

public class TestDB {

    public static void main(String[] args) {

        Connection conn = DBConnection.getConnection();

        if (conn != null) {
            System.out.println("✅ CONEXIÓN OK");
        } else {
            System.out.println("❌ ERROR DE CONEXIÓN");
        }
    }
}