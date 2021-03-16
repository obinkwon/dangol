package model;

public class Order {
	private int ord;
	private int snum;
	private String oname;
	private int oprice;
	private String oimage;
	public int getOrd() {
		return ord;
	}
	public void setOrd(int ord) {
		this.ord = ord;
	}
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public String getOname() {
		return oname;
	}
	public void setOname(String oname) {
		this.oname = oname;
	}
	public int getOprice() {
		return oprice;
	}
	public void setOprice(int oprice) {
		this.oprice = oprice;
	}
	public String getOimage() {
		return oimage;
	}
	public void setOimage(String oimage) {
		this.oimage = oimage;
	}
	public Order() {}
	public Order(int ord, int snum, String oname, int oprice, String oimage) {
		this.ord = ord;
		this.snum = snum;
		this.oname = oname;
		this.oprice = oprice;
		this.oimage = oimage;
	}
	@Override
	public String toString() {
		return "Order [ord=" + ord + ", snum=" + snum + ", oname=" + oname + ", oprice=" + oprice + ", oimage="
				+ oimage + "]";
	}
	
}
