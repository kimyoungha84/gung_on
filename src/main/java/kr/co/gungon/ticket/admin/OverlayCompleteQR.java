package kr.co.gungon.ticket.admin;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;
public class OverlayCompleteQR {

	public void usedCompleteQRcode(String path,String qrimageName) {
		  try {
			  String imagePath=path+qrimageName;
			   BufferedImage qrImg = ImageIO.read(new File(imagePath));
			   BufferedImage usedCompleteImg = ImageIO.read(new File("http://localhost/Gung_On/ticket/images/usedComplete.png"));
		
			   int width = qrImg.getWidth();//200
			   int height = qrImg.getHeight();//200
		
			   BufferedImage mergedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
			   Graphics2D graphics = (Graphics2D) mergedImage.getGraphics();
		
			   graphics.setBackground(Color.WHITE);
			   graphics.drawImage(qrImg, 0, 0, null);
			   graphics.drawImage(usedCompleteImg, 10, 20, null);
			   
			   String writePath=path+qrimageName;
			   ImageIO.write(mergedImage, "png", new File(writePath));
			   // ImageIO.write(mergedImage, "jpg", new File("c:/mergedImage.jpg"));
			   // ImageIO.write(mergedImage, "png", new File("c:/mergedImage.png"));
			  } catch (IOException ioe) {
			   ioe.printStackTrace();
		  }//end try~catch
	
	 }//usedCompleteQRcode
	
}//class
