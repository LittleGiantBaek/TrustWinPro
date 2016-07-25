package com.Trustwin.Admin.Project.socket;

import java.awt.AWTException;
import java.awt.Robot;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.Socket;
import java.net.UnknownHostException;


public class Client {
	
	/**
	 * 
	 * Desc :
	 * @Method Name : main
	 * @param argv
	 *
	 */
    public void Start(String ip, int port) {
    	Socket socket = null;
    	DataOutputStream bos = null;
    	DataInputStream dis = null;
    	         
        try {
        	socket = new Socket(ip,port);
        	
        	dis = new DataInputStream(socket.getInputStream());     	        	
        	byte[] c = new byte[10000];
            

            dis.read(c, 0, c.length); 
            String input = new String(c,0,c.length); 
            input = input.trim();   
        	
            System.out.println(input);
        	
        	bos = new DataOutputStream(socket.getOutputStream());        	        	
        	byte[] b = new byte[1024];
        	b = "abc".getBytes();
        	bos.write(b);
        	bos.flush();
        	
        	bos.close();
        	dis.close();
        	socket.close();
            

        } catch (UnknownHostException e) {
            System.out.println("Unkonw exception " + e.getMessage());
        } catch (IOException e) {
            System.out.println("IOException caught " + e.getMessage());
            e.printStackTrace();
        } 
    }

	
}