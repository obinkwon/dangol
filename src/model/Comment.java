package model;

import java.util.Date;

public class Comment {
	private int cnum;
	private int dnum;
	private double ctotal;
	private String ctaste;
	private double cservice;
	private double cprice;
	private Date cdate;
	private String creview;
	private String mid;
	private int gnum;
	private String mimage;
	
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public int getDnum() {
		return dnum;
	}
	public void setDnum(int dnum) {
		this.dnum = dnum;
	}
	public double getCtotal() {
		return ctotal;
	}
	public void setCtotal(double ctotal) {
		this.ctotal = ctotal;
	}
	public String getCtaste() {
		return ctaste;
	}
	public void setCtaste(String ctaste) {
		this.ctaste = ctaste;
	}
	public double getCservice() {
		return cservice;
	}
	public void setCservice(double cservice) {
		this.cservice = cservice;
	}
	public double getCprice() {
		return cprice;
	}
	public void setCprice(double cprice) {
		this.cprice = cprice;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public String getCreview() {
		return creview;
	}
	public void setCreview(String creview) {
		this.creview = creview;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getGnum() {
		return gnum;
	}
	public void setGnum(int gnum) {
		this.gnum = gnum;
	}
	public String getMimage() {
		return mimage;
	}
	public void setMimage(String mimage) {
		this.mimage = mimage;
	}
	public Comment() {}
	public Comment(int cnum, int dnum, double ctotal, String ctaste, double cservice, double cprice, Date cdate,
			String creview) {
		this.cnum = cnum;
		this.dnum = dnum;
		this.ctotal = ctotal;
		this.ctaste = ctaste;
		this.cservice = cservice;
		this.cprice = cprice;
		this.cdate = cdate;
		this.creview = creview;
	}
	@Override
	public String toString() {
		return "Comment [cnum=" + cnum + ", dnum=" + dnum + ", ctotal=" + ctotal + ", ctaste=" + ctaste + ", cservice="
				+ cservice + ", cprice=" + cprice + ", cdate=" + cdate + ", creview=" + creview + "]";
	}
	
	
	
}
