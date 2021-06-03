package model;

public class Member {
	private String mid;
    private String mpw;
    private String mphone;
    private String maddress;
    private String maddress_d;
    private String mgender;
    private String mjob;
    private String mtype;
    private String marea1;
    private String marea2;
    private String mimage;
    private int mpenalty;
    private String mtag;
    private String avalue;
	private String anum;
	private int snum;
	private int glike;
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMpw() {
		return mpw;
	}
	public void setMpw(String mpw) {
		this.mpw = mpw;
	}
	public String getMphone() {
		return mphone;
	}
	public void setMphone(String mphone) {
		this.mphone = mphone;
	}
	public String getMaddress() {
		return maddress;
	}
	public void setMaddress(String maddress) {
		this.maddress = maddress;
	}
	public String getMaddress_d() {
		return maddress_d;
	}
	public void setMaddress_d(String maddress_d) {
		this.maddress_d = maddress_d;
	}
	public String getMgender() {
		return mgender;
	}
	public void setMgender(String mgender) {
		this.mgender = mgender;
	}
	public String getMjob() {
		return mjob;
	}
	public void setMjob(String mjob) {
		this.mjob = mjob;
	}
	public String getMtype() {
		return mtype;
	}
	public void setMtype(String mtype) {
		this.mtype = mtype;
	}
	public String getMarea1() {
		return marea1;
	}
	public void setMarea1(String marea1) {
		this.marea1 = marea1;
	}
	public String getMarea2() {
		return marea2;
	}
	public void setMarea2(String marea2) {
		this.marea2 = marea2;
	}
	public String getMimage() {
		return mimage;
	}
	public void setMimage(String mimage) {
		this.mimage = mimage;
	}
	public int getMpenalty() {
		return mpenalty;
	}
	public void setMpenalty(int mpenalty) {
		this.mpenalty = mpenalty;
	}
	public String getMtag() {
		return mtag;
	}
	public void setMtag(String mtag) {
		this.mtag = mtag;
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
	public int getSnum() {
		return snum;
	}
	public void setSnum(int snum) {
		this.snum = snum;
	}
	public int getGlike() {
		return glike;
	}
	public void setGlike(int glike) {
		this.glike = glike;
	}
	public Member() {}
	
	public Member(String mid, String mpw, String mphone, String maddress, String maddress_d, String mgender,
			String mjob, String mtype, String marea1, String marea2, String mimage, int mpenalty) {
		super();
		this.mid = mid;
		this.mpw = mpw;
		this.mphone = mphone;
		this.maddress = maddress;
		this.maddress_d = maddress_d;
		this.mgender = mgender;
		this.mjob = mjob;
		this.mtype = mtype;
		this.marea1 = marea1;
		this.marea2 = marea2;
		this.mimage = mimage;
		this.mpenalty = mpenalty;
	}
	
	@Override
	public String toString() {
		return "Member [mid=" + mid + ", mpw=" + mpw + ", mphone=" + mphone + ", maddress=" + maddress + ", maddress_d="
				+ maddress_d + ", mgender=" + mgender + ", mjob=" + mjob + ", mtype=" + mtype + ", marea1=" + marea1
				+ ", marea2=" + marea2 + ", mimage=" + mimage + ", mpenalty=" + mpenalty + "]";
	};
	
	
    
}
