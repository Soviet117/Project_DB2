package model;

/**
 *
 * @author Soviet
 */
public class Nota {
    private int id_nota;
    private String codigo;
    private String nombre;
    private int credito;
    private double p1;
    private double p2;
    private double p3;
    private double p4;
    private double c1;
    private double c2;
    private double c3;
    private double c4;
    private double c5;
    private double c6;
    private double continuas;
    private double total;
    
    public Nota(){
        
    }

    public Nota(int id_nota, String codigo, String nombre, int credito, double p1, 
                double p2, double p3, double p4, double c1, double c2, double c3,
                double c4, double c5, double c6, double continuas, double total) {
        this.id_nota = id_nota;
        this.codigo = codigo;
        this.nombre = nombre;
        this.credito = credito;
        this.p1 = p1;
        this.p2 = p2;
        this.p3 = p3;
        this.p4 = p4;
        this.c1 = c1;
        this.c2 = c2;
        this.c3 = c3;
        this.c4 = c4;
        this.c5 = c5;
        this.c6 = c6;
        this.continuas = continuas;
        this.total = total;
    }

    public int getId_nota() {
        return id_nota;
    }

    public void setId_nota(int id_nota) {
        this.id_nota = id_nota;
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
    
    public int getCredito() {
        return credito;
    }

    public void setCredito(int credito) {
        this.credito = credito;
    }

    public double getP1() {
        return p1;
    }

    public void setP1(double p1) {
        this.p1 = p1;
    }

    public double getP2() {
        return p2;
    }

    public void setP2(double p2) {
        this.p2 = p2;
    }

    public double getP3() {
        return p3;
    }

    public void setP3(double p3) {
        this.p3 = p3;
    }

    public double getP4() {
        return p4;
    }

    public void setP4(double p4) {
        this.p4 = p4;
    }

    public double getC1() {
        return c1;
    }

    public void setC1(double c1) {
        this.c1 = c1;
    }

    public double getC2() {
        return c2;
    }

    public void setC2(double c2) {
        this.c2 = c2;
    }

    public double getC3() {
        return c3;
    }

    public void setC3(double c3) {
        this.c3 = c3;
    }

    public double getC4() {
        return c4;
    }

    public void setC4(double c4) {
        this.c4 = c4;
    }

    public double getC5() {
        return c5;
    }

    public void setC5(double c5) {
        this.c5 = c5;
    }

    public double getC6() {
        return c6;
    }

    public void setC6(double c6) {
        this.c6 = c6;
    }

    public double getContinuas() {
        return continuas;
    }

    public void setContinuas(double continuas) {
        this.continuas = continuas;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "Nota{" + "id_nota=" + id_nota + ", codigo=" + codigo + ", nombre=" + nombre + ", credito=" + credito + ", p1=" + p1 + ", p2=" + p2 + ", p3=" + p3 + ", p4=" + p4 + ", c1=" + c1 + ", c2=" + c2 + ", c3=" + c3 + ", c4=" + c4 + ", c5=" + c5 + ", c6=" + c6 + ", continuas=" + continuas + ", total=" + total + '}';
    }
    
    
}
