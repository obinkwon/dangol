package model;

import java.sql.Date;

public class Inquiry {
	private int inum;
	private String mid;
	private String bid;
	private String itype;
	private String ititle;
	private String icontent;
	private Date idate;
	private String istate;
	private String ianswer;
	private int cnt;
	private String mphone;
	private String bphone;
	private int rownum;
	public int getInum() {
		return inum;
	}
	public void setInum(int inum) {
		this.inum = inum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getBid() {
		return bid;
	}
	public void setBid(String bid) {
		this.bid = bid;
	}
	public String getItype() {
		return itype;
	}
	public void setItype(String itype) {
		this.itype = itype;
	}
	public String getItitle() {
		return ititle;
	}
	public void setItitle(String ititle) {
		this.ititle = ititle;
	}
	public String getIcontent() {
		return icontent;
	}
	public void setIcontent(String icontent) {
		this.icontent = icontent;
	}
	public Date getIdate() {
		return idate;
	}
	public void setIdate(Date idate) {
		this.idate = idate;
	}
	public String getIstate() {
		return istate;
	}
	public void setIstate(String istate) {
		this.istate = istate;
	}
	public String getIanswer() {
		return ianswer;
	}
	public void setIanswer(String ianswer) {
		this.ianswer = ianswer;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public String getMphone() {
		return mphone;
	}
	public void setMphone(String mphone) {
		this.mphone = mphone;
	}
	public String getBphone() {
		return bphone;
	}
	public void setBphone(String bphone) {
		this.bphone = bphone;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public Inquiry() {}
	public Inquiry(int inum, String mid, String bid, String itype, String ititle, String icontent, Date idate,
			String istate, String ianswer, int cnt, String mphone, String bphone) {
		this.inum = inum;
		this.mid = mid;
		this.bid = bid;
		this.itype = itype;
		this.ititle = ititle;
		this.icontent = icontent;
		this.idate = idate;
		this.istate = istate;
		this.ianswer = ianswer;
		this.cnt = cnt;
		this.mphone = mphone;
		this.bphone = bphone;
	}
	@Override
	public String toString() {
		return "Inquiry [inum=" + inum + ", mid=" + mid + ", bid=" + bid + ", itype=" + itype + ", ititle=" + ititle
				+ ", icontent=" + icontent + ", idate=" + idate + ", istate=" + istate + ", ianswer=" + ianswer
				+ ", cnt=" + cnt + ", mphone="+ mphone +", bphone="+ bphone +"]";
	}
	
}
