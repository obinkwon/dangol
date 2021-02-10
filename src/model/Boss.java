package model;

public class Boss {
	private String bid;
	private String bpw;
	private String bphone;
	public String getBid() {
		return bid;
	}
	public void setBid(String bid) {
		this.bid = bid;
	}
	public String getBpw() {
		return bpw;
	}
	public void setBpw(String bpw) {
		this.bpw = bpw;
	}
	public String getBphone() {
		return bphone;
	}
	public void setBphone(String bphone) {
		this.bphone = bphone;
	}
	public Boss() {}
	public Boss(String bid, String bpw, String bphone) {
		this.bid = bid;
		this.bpw = bpw;
		this.bphone = bphone;
	}
	@Override
	public String toString() {
		return "Boss [bid=" + bid + ", bpw=" + bpw + ", bphone=" + bphone + "]";
	}
	
}
