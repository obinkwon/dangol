package model;

public class Mtag {
	private int mtnum;
	private String mid;
	private int anum;
	public int getMtnum() {
		return mtnum;
	}
	public void setMtnum(int mtnum) {
		this.mtnum = mtnum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getAnum() {
		return anum;
	}
	public void setAnum(int anum) {
		this.anum = anum;
	}
	public Mtag() {}
	public Mtag(int mtnum, String mid, int anum) {
		this.mtnum = mtnum;
		this.mid = mid;
		this.anum = anum;
	}
	@Override
	public String toString() {
		return "Mtag [mtnum=" + mtnum + ", mid=" + mid + ", anum=" + anum + "]";
	}
	
}
