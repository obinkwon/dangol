package model;

public class Grade {
	private int gnum;
	private String mid;
	private int snum;
	private int glevel;
	private String gcurrent;
	private int glike;
	
	public int getGnum() {
		return gnum;
	}
	public void setGnum(int gnum) {
		this.gnum = gnum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public int getGlevel() {
		return glevel;
	}
	public void setGlevel(int glevel) {
		this.glevel = glevel;
	}
	public String getGcurrent() {
		return gcurrent;
	}
	public void setGcurrent(String gcurrent) {
		this.gcurrent = gcurrent;
	}
	public int getGlike() {
		return glike;
	}
	public void setGlike(int glike) {
		this.glike = glike;
	}
	public Grade() {}
	public Grade(int gnum, String mid, int snum, int glevel, String gcurrent, int glike) {
		this.gnum = gnum;
		this.mid = mid;
		this.snum = snum;
		this.glevel = glevel;
		this.gcurrent = gcurrent;
		this.glike = glike;
	}
	@Override
	public String toString() {
		return "Grade [gnum=" + gnum + ", mid=" + mid + ", snum=" + snum + ", glevel=" + glevel + ", gcurrent="
				+ gcurrent + ", glike=" + glike + "]";
	}
	
}
