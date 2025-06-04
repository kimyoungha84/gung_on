package kr.co.gungon.ticket;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
 
import org.apache.commons.net.PrintCommandListener;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
 
public class FileUploadFTP {
    
    FTPClient ftp = null;
    
    //param( host server ip, username, password )
    public FileUploadFTP(String host, String user, String pwd) throws Exception{
        ftp = new FTPClient();
        ftp.addProtocolCommandListener(new PrintCommandListener(new PrintWriter(System.out)));
        int reply;
        ftp.connect(host);//호스트 연결
        reply = ftp.getReplyCode();
        if (!FTPReply.isPositiveCompletion(reply)) {
            ftp.disconnect();
            throw new Exception("Exception in connecting to FTP Server");
        }
        ftp.login(user, pwd);//로그인
        ftp.setFileType(FTP.BINARY_FILE_TYPE);
        ftp.enterLocalPassiveMode();
    }//FileUploadFTP(생성자)
    
    
    
    
    //param( 보낼파일경로+파일명, 호스트에서 받을 파일 이름, 호스트 디렉토리 )
    public void uploadFile(String localFileFullName, String fileName, String hostDir) throws Exception {
        try(InputStream input = new FileInputStream(new File(localFileFullName))){
        	
        	this.ftp.storeFile(hostDir + fileName, input);
        	//storeFile() 메소드가 전송하는 메소드
        }
    }//uploadFile
 
    
    /*연결 끊기*/
    public void disconnect(){
        if (this.ftp.isConnected()) {
            try {
                this.ftp.logout();
                this.ftp.disconnect();
            } catch (IOException f) {
                f.printStackTrace();
            }
        }//end if
    }//disconnect
    
    /*
    public static void main(String[] args) throws Exception {
        System.out.println("Start");
        FileUploadFTP ftpUploader = new FileUploadFTP("192.168.0.153", "jdk", "1234");
        ftpUploader.uploadFile("C:\\Users\\jdg\\Desktop\\jeongpro\\hello.txt", "hello.txt", "/home/jdk/");
        ftpUploader.disconnect();
        System.out.println("Done");
    }//main
 */
}//class