package model;

import java.util.Arrays;
import java.util.List;

public class Admin {
	private int anum;
	private String atype;
	private String avalue;
	private String aimage;
	private int offset;
	private int storesPerPage;
	private int page;
	private int startPage;
	private int endPage;
	private int lastPage;
	private String type;
	private String areaName;
	private String mid;
	private String maddress;
	private String marea1;
	private String marea2;
	public List<Integer> anumList;
	
	
	
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
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public List<Integer> getAnumList() {
		return anumList;
	}
	public void setAnumList(List<Integer> anumList) {
		this.anumList = anumList;
	}
	public String getMaddress() {
		return maddress;
	}
	public void setMaddress(String maddress) {
		this.maddress = maddress;
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
	
}
