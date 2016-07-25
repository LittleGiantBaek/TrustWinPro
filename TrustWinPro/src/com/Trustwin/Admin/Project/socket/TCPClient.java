package com.Trustwin.Admin.Project.socket;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
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
		// 소켓의 입력스트림을 얻는다.
        InputStream in = socket.getInputStream();
        DataInputStream dis = new DataInputStream(in);  // 기본형 단위로 처리하는 보조스트림
        int str = 0;
        str = dis.read();
        return str;
	}
	
	public void output(String str) throws IOException{
		 // 소켓의 출력스트림을 얻는다.
        OutputStream out = socket.getOutputStream(); 
        DataOutputStream dos = new DataOutputStream(out); // 기본형 단위로 처리하는 보조스트림
        if( socket.isConnected() == true && socket.getKeepAlive() == false) {
        	socket.setKeepAlive(true);
        	if(socket.getKeepAlive() == false){
        			socket.close();
        	}
        }
        
        char strChar;
        for(int i=0;i<str.length();i++){
        	strChar = str.charAt(i);
        	dos.write(strChar);
        }
	}
	
	
	public void end() throws UnknownHostException, IOException{
		socket.close();
	}
	
} 