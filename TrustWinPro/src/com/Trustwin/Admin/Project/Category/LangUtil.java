package com.Trustwin.Admin.Project.Category;

public class LangUtil {

	public static String Empty(String str){
		String v = "";
		if(str!=null){
			if(str.equals("") || str.equals(null)){
				v = "";
			}else{
				v = str;
			}
		}
		
		return v;
	}
}
