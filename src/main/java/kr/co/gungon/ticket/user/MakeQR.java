package kr.co.gungon.ticket.user;


import java.io.File;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;

import kr.co.gungon.ticket.ticketConfig.SiteProperty;



public class MakeQR {

	// QR파일을 생성해서 파일로 저장
	public void  makeQR(String imgName) {
		StringBuilder content=null;

	    try { 
	        content = new StringBuilder();
	        content.append(SiteProperty.qrStorePath).append("?img=").append(imgName);
	        
	        MultiFormatWriter writer = new MultiFormatWriter();

	        // 200, 200은 가로, 세로 크기
	        BitMatrix matrix = writer.encode( content.toString(), BarcodeFormat.QR_CODE, 200, 200 );

	        String dirpath=SiteProperty.uploadQRPathInCom;// /Gung_On/common/images/upload/QR
	        File dirPathFile=new File(dirpath);
	        
	        //String thisPath=dirPathFile.getCanonicalPath();
	        String thisPath=dirPathFile.getPath();
	        
	        
	        /*QRimage 디렉토리 없으면 만들기!*/
	        if(!dirPathFile.exists()) {
	        	dirPathFile.mkdirs();
	        };
	        
	        //File file = new File( "D:/test.png" );
	        File file=new File(thisPath+"/"+imgName+".png");
	        // MatrixToImageWriter.writeToFile( matrix, "png", file );
	        System.out.println(file.toPath());
	        MatrixToImageWriter.writeToPath( matrix, "png",  file.toPath());
	        
	        
	        
	        
	    }
	    catch( Exception e ) {
	        e.printStackTrace();
	    }//try~catch
	    
	}//makeQR
	
	

	
/*	
	public static void main(String[] args) {
		makeQR("456456");
		
	}//main
*/
}//class
