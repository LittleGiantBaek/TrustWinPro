package com.Trustwin.Admin.Project.socket;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.Socket;
import java.net.UnknownHostException;
 
public class TCPClient extends Thread{
	
	private Socket socket;
	
	public TCPClient(String ip, int port) throws UnknownHostException, IOException{
		socket = new Socket(ip, port);
	}  
	
	public int input() throws IOException{
		if( socket.isConnected() == true && socket.getKeepAlive() == false) {
        	socket.close();
        }
		
        InputStream in = socket.getInputStream();
        DataInputStream dis = new DataInputStream(in); 
        int str = 0;
        str = dis.read();
        return str;
	}
	
	public void output(String str) throws IOException{
		
        OutputStream out = socket.getOutputStream(); 
        DataOutputStream dos = new DataOutputStream(out);
   
        if( socket.isConnected() == true && socket.getKeepAlive() == false) {
        	socket.setKeepAlive(true);
        	if(socket.getKeepAlive() == false){
        			socket.close();
        	}
        }

        dos.writeUTF(str);
        
      /*  String new_str = "";
        char strChar;
        
        for(int i=0;i<str.length();i++){
        	new_str += str.charAt(i);
        }
        dos.writeUTF(new_str);*/
	}
	
	
	public void end() throws UnknownHostException, IOException{
		socket.close();
	}
	
} 