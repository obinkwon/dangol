package model;

public class Stag {
	private int stnum;
	private int snum;
	private int anum;
	public int getStnum() {
		return stnum;
	}
	public void setStnum(int stnum) {
		this.stnum = stnum;
	}
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public int getAnum() {
		return anum;
	}
	public void setAnum(int anum) {
		this.anum = anum;
	}
	public Stag() {}
	public Stag(int stnum, int snum, int anum) {
		this.stnum = stnum;
		this.snum = snum;
		this.anum = anum;
	}
	@Override
	public String toString() {
		return "Stag [stnum=" + stnum + ", snum=" + snum + ", anum=" + anum + "]";
	} 
	
}
