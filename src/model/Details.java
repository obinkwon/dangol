package model;

import java.sql.Date;

public class Details {
	private int dnum;
	private int gnum;
	private Date ddate;
	private int dperson;
	private String dmenu;
	private String dtype;
	private String dask;
	private String dcheck;
	private String dtime;
	private int dcount;
	private int dlimit;
	private String dpermit;
	private String mid;
	private int snum;
	public int getDnum() {
		return dnum;
	}
	public void setDnum(int dnum) {
		this.dnum = dnum;
	}
	public int getGnum() {
		return gnum;
	}
	public void setGnum(int gnum) {
		this.gnum = gnum;
	}
	public Date getDdate() {
		return ddate;
	}
	public void setDdate(Date ddate) {
		this.ddate = ddate;
	}
	public int getDperson() {
		return dperson;
	}
	public void setDperson(int dperson) {
		this.dperson = dperson;
	}
	public String getDmenu() {
		return dmenu;
	}
	public void setDmenu(String dmenu) {
		this.dmenu = dmenu;
	}
	public String getDtype() {
		return dtype;
	}
	public void setDtype(String dtype) {
		this.dtype = dtype;
	}
	public String getDask() {
		return dask;
	}
	public void setDask(String dask) {
		this.dask = dask;
	}
	public String getDcheck() {
		return dcheck;
	}
	public void setDcheck(String dcheck) {
		this.dcheck = dcheck;
	}
	public String getDtime() {
		return dtime;
	}
	public void setDtime(String dtime) {
		this.dtime = dtime;
	}
	public int getDcount() {
		return dcount;
	}
	public void setDcount(int dcount) {
		this.dcount = dcount;
	}
	public int getDlimit() {
		return dlimit;
	}
	public void setDlimit(int dlimit) {
		this.dlimit = dlimit;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getDpermit() {
		return dpermit;
	}
	public void setDpermit(String dpermit) {
		this.dpermit = dpermit;
	}
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public Details() {}
	public Details(int dnum, int gnum, Date ddate, int dperson, String dmenu, String dtype, String dask, String dcheck,
			String dtime, int dcount, int dlimit, String dpermit) {
		this.dnum = dnum;
		this.gnum = gnum;
		this.ddate = ddate;
		this.dperson = dperson;
		this.dmenu = dmenu;
		this.dtype = dtype;
		this.dask = dask;
		this.dcheck = dcheck;
		this.dtime = dtime;
		this.dcount = dcount;
		this.dlimit = dlimit;
		this.dpermit = dpermit;
	}
	@Override
	public String toString() {
		return "Details [dnum=" + dnum + ", gnum=" + gnum + ", ddate=" + ddate + ", dperson=" + dperson + ", dmenu="
				+ dmenu + ", dtype=" + dtype + ", dask=" + dask + ", dcheck=" + dcheck + ", dtime=" + dtime
				+ ", dcount=" + dcount + ", dlimit=" + dlimit + ", dpermit=" + dpermit + "]";
	}
}
