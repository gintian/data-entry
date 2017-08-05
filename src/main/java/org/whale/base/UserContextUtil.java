package org.whale.base;

import org.whale.system.common.util.ThreadContext;
import org.whale.system.controller.login.UserContext;

public class UserContextUtil {
	public static UserContext getUserContext(){
		return (UserContext)ThreadContext.getContext().get(ThreadContext.KEY_USER_CONTEXT);
	}
}
