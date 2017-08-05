package org.whale.pu.exception;

public class NeedPersonExcption extends RuntimeException {
	private String[] needRoles;
	
	public NeedPersonExcption(String[] needRoles){
		super("needPersonException");
		this.needRoles = needRoles;
	}
	
	public String[] getNeedRoles() {
		return needRoles;
	}

	public void setNeedRoles(String[] needRoles) {
		this.needRoles = needRoles;
	}




	private static final long serialVersionUID = 7083800707551028080L;


}
