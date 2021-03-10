package model;

import java.util.Date;

public class Store {
	private int snum;
	private String bid;
	private String sintro;
	private String sname;
	private String saddress;
	private String sdetailaddr;
	private String sphone;
	private String stime_start;
	private String sparking;
	private String simage;
	private String stype;
	private String sholiday;
	private String sdate;
	private int sratelv0;
	private int sratelv1;
	private int sratelv2;
	private int sratelv3;
	private int slimit;
	private double slatitude;
	private double slongitude;
	private String stime_end;
	private int dancnt;
	private int commentTotal;
	private String stag;
	private String avalue;
	private String anum;
	
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public String getBid() {
		return bid;
	}
	public void setBid(String bid) {
		this.bid = bid;
	}
	public String getSintro() {
		return sintro;
	}
	public void setSintro(String sintro) {
		this.sintro = sintro;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getSaddress() {
		return saddress;
	}
	public void setSaddress(String saddress) {
		this.saddress = saddress;
	}
	public String getSdetailaddr() {
		return sdetailaddr;
	}
	public void setSdetailaddr(String sdetailaddr) {
		this.sdetailaddr = sdetailaddr;
	}
	public String getSphone() {
		return sphone;
	}
	public void setSphone(String sphone) {
		this.sphone = sphone;
	}
	public String getSparking() {
		return sparking;
	}
	public void setSparking(String sparking) {
		this.sparking = sparking;
	}
	public String getSimage() {
		return simage;
	}
	public void setSimage(String simage) {
		this.simage = simage;
	}
	public String getStype() {
		return stype;
	}
	public void setStype(String stype) {
		this.stype = stype;
	}
	public String getSholiday() {
		return sholiday;
	}
	public void setSholiday(String sholiday) {
		this.sholiday = sholiday;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public int getSratelv0() {
		return sratelv0;
	}
	public void setSratelv0(int sratelv0) {
		this.sratelv0 = sratelv0;
	}
	public int getSratelv1() {
		return sratelv1;
	}
	public void setSratelv1(int sratelv1) {
		this.sratelv1 = sratelv1;
	}
	public int getSratelv2() {
		return sratelv2;
	}
	public void setSratelv2(int sratelv2) {
		this.sratelv2 = sratelv2;
	}
	public int getSratelv3() {
		return sratelv3;
	}
	public void setSratelv3(int sratelv3) {
		this.sratelv3 = sratelv3;
	}
	public int getSlimit() {
		return slimit;
	}
	public void setSlimit(int slimit) {
		this.slimit = slimit;
	}
	public double getSlatitude() {
		return slatitude;
	}
	public void setSlatitude(double slatitude) {
		this.slatitude = slatitude;
	}
	public double getSlongitude() {
		return slongitude;
	}
	public void setSlongitude(double slongitude) {
		this.slongitude = slongitude;
	}
	public String getStime_start() {
		return stime_start;
	}
	public void setStime_start(String stime_start) {
		this.stime_start = stime_start;
	}
	public String getStime_end() {
		return stime_end;
	}
	public void setStime_end(String stime_end) {
		this.stime_end = stime_end;
	}
	public int getDancnt() {
		return dancnt;
	}
	public void setDancnt(int dancnt) {
		this.dancnt = dancnt;
	}
	public int getCommentTotal() {
		return commentTotal;
	}
	public void setCommentTotal(int commentTotal) {
		this.commentTotal = commentTotal;
	}
	public String getStag() {
		return stag;
	}
	public void setStag(String stag) {
		this.stag = stag;
	}
	public String getAvalue() {
		return avalue;
	}
	public void setAvalue(String avalue) {
		this.avalue = avalue;
	}
	public String getAnum() {
		return anum;
	}
	public void setAnum(String anum) {
		this.anum = anum;
	}
	@Override
	public String toString() {
		return "Store [snum=" + snum + ", bid=" + bid + ", sintro=" + sintro + ", sname=" + sname + ", saddress="
				+ saddress + ", sdetailaddr=" + sdetailaddr + ", sphone=" + sphone + ", stime_start=" + stime_start
				+ ", sparking=" + sparking + ", simage=" + simage + ", stype=" + stype + ", sholiday=" + sholiday
				+ ", sdate=" + sdate + ", sratelv0=" + sratelv0 + ", sratelv1=" + sratelv1 + ", sratelv2=" + sratelv2
				+ ", sratelv3=" + sratelv3 + ", slimit=" + slimit + ", slatitude=" + slatitude + ", slongitude="
				+ slongitude + ", stime_end=" + stime_end + ", dancnt=" + dancnt + ", commentTotal=" + commentTotal
				+ ", stag=" + stag + "]";
	}
	public Store() {}
	public Store(int snum, String bid, String sintro, String sname, String saddress, String sdetailaddr, String sphone,
			String stime_start, String sparking, String simage, String stype, String sholiday, String sdate, int sratelv0,
			int sratelv1, int sratelv2, int sratelv3, int slimit, double slatitude, double slongitude, String stime_end,
			int dancnt, int commentTotal, String stag) {
		super();
		this.snum = snum;
		this.bid = bid;
		this.sintro = sintro;
		this.sname = sname;
		this.saddress = saddress;
		this.sdetailaddr = sdetailaddr;
		this.sphone = sphone;
		this.stime_start = stime_start;
		this.sparking = sparking;
		this.simage = simage;
		this.stype = stype;
		this.sholiday = sholiday;
		this.sdate = sdate;
		this.sratelv0 = sratelv0;
		this.sratelv1 = sratelv1;
		this.sratelv2 = sratelv2;
		this.sratelv3 = sratelv3;
		this.slimit = slimit;
		this.slatitude = slatitude;
		this.slongitude = slongitude;
		this.stime_end = stime_end;
		this.dancnt = dancnt;
		this.commentTotal = commentTotal;
		this.stag = stag;
	}
	
}
