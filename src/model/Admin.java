package model;

public class Admin {
	private int anum;
	private String atype;
	private String avalue;
	private String aimage;
	private int offset;
	private int storesPerPage;
	
	
	public int getAnum() {
		return anum;
	}
	public void setAnum(int anum) {
		this.anum = anum;
	}
	public String getAtype() {
		return atype;
	}
	public void setAtype(String atype) {
		this.atype = atype;
	}
	public String getAvalue() {
		return avalue;
	}
	public void setAvalue(String avalue) {
		this.avalue = avalue;
	}
	public String getAimage() {
		return aimage;
	}
	public void setAimage(String aimage) {
		this.aimage = aimage;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getStoresPerPage() {
		return storesPerPage;
	}
	public void setStoresPerPage(int storesPerPage) {
		this.storesPerPage = storesPerPage;
	}
	public Admin() {}
	public Admin(int anum, String atype, String avalue, String aimage) {
		this.anum = anum;
		this.atype = atype;
		this.avalue = avalue;
		this.aimage = aimage;
	}
	@Override
	public String toString() {
		return "Admin [anum=" + anum + ", atype=" + atype + ", avalue=" + avalue + ", aimage=" + aimage + "]";
	}
	
}
