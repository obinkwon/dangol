package model;

public class Storedb {
	private String name;
	private String type;
	private String address;
	private double latitude;
	private double longitude;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public Storedb() {}
	public Storedb(String name, String type, String address, double latitude, double longitude) {
		this.name = name;
		this.type = type;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
	}
	@Override
	public String toString() {
		return "Storedb [name=" + name + ", type=" + type + ", address=" + address + ", latitude=" + latitude
				+ ", longitude=" + longitude + "]";
	}
}
