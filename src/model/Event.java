package model;

import java.sql.Date;

public class Event {
	private int eid;
	private int snum;
	private String etitle;
	private Date estartdate;
	private Date eenddate;
	private String etarget1;
	private String etarget2;
	private String eimage;
	private String status;
	private String sname;
	
	public int getEid() {
		return eid;
	}
	public void setEid(int eid) {
		this.eid = eid;
	}
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public String getEtitle() {
		return etitle;
	}
	public void setEtitle(String etitle) {
		this.etitle = etitle;
	}
	public Date getEstartdate() {
		return estartdate;
	}
	public void setEstartdate(Date estartdate) {
		this.estartdate = estartdate;
	}
	public Date getEenddate() {
		return eenddate;
	}
	public void setEenddate(Date eenddate) {
		this.eenddate = eenddate;
	}
	public String getEtarget1() {
		return etarget1;
	}
	public void setEtarget1(String etarget1) {
		this.etarget1 = etarget1;
	}
	public String getEimage() {
		return eimage;
	}
	public void setEimage(String eimage) {
		this.eimage = eimage;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSname() {
		return sname;
	}
	public void setSname(String sname) {
		this.sname = sname;
	}
	public String getEtarget2() {
		return etarget2;
	}
	public void setEtarget2(String etarget2) {
		this.etarget2 = etarget2;
	}
	public Event() {}
	
	public Event(int eid, int snum, String etitle, Date estartdate, Date eenddate, String etarget1, String etarget2,
			String eimage, String status, String sname) {
		super();
		this.eid = eid;
		this.snum = snum;
		this.etitle = etitle;
		this.estartdate = estartdate;
		this.eenddate = eenddate;
		this.etarget1 = etarget1;
		this.etarget2 = etarget2;
		this.eimage = eimage;
		this.status = status;
		this.sname = sname;
	}
	
	@Override
	public String toString() {
		return "Event [eid=" + eid + ", snum=" + snum + ", etitle=" + etitle + ", estartdate=" + estartdate
				+ ", eenddate=" + eenddate + ", etarget1=" + etarget1 + ", etarget2=" + etarget2 + ", eimage=" + eimage
				+ ", status=" + status + ", sname=" + sname + "]";
	}
	
	
	
}
