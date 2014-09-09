package com.st.olm.cq.api.utility;

public enum ImportUtilityType {
	COUNTRY(0), REGION(1), CITY(2);

	private int type;

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	private ImportUtilityType(int type) {
		this.type = type;
	}

}
