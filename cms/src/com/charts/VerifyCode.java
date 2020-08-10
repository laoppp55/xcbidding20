package com.charts;

import org.junit.Test;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.Random;
import javax.imageio.ImageIO;

//该类包含一些用来查找 ImageReader 和 ImageWriter 以及执行简单编码和解码的静态便捷方法。
public class VerifyCode {
    //把上面的字符串改成我们平时用的验证码---生成几个随机数字，有背景色和干扰线
    @Test
    public void ImgDemo2() throws FileNotFoundException, IOException{
        int width = 80;
        int height= 40;
        int lines = 10;
        BufferedImage img = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        Graphics g = img.getGraphics();

        //设置背景色
        g.setColor(Color.white);
        g.fillRect(0, 0, width, height);//画背景
        //填充指定的矩形。使用图形上下文的当前颜色填充该矩形

        //设置字体
        g.setFont(new Font("宋体", Font.BOLD, 18));

        //随机数字
        Date d = new Date();
        //System.out.println(d.getTime());
        Random r = new Random(d.getTime());
        for(int i=0;i<4;i++){
            int a = r.nextInt(10);//取10以内的整数[0，9]
            int y = 10+r.nextInt(20); //10~30范围内的一个整数，作为y坐标
            Color c = new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255));
            g.setColor(c);
            g.drawString(""+a, 5+i*width/4, y);
        }
        //干扰线
        for(int i=0;i<lines;i++){
            Color c = new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255));
            g.setColor(c);
            g.drawLine(r.nextInt(width), r.nextInt(height), r.nextInt(width), r.nextInt(height));
        }

        g.dispose();//类似于流中的close()带动flush()---把数据刷到img对象当中
        ImageIO.write(img, "JPG", new FileOutputStream("img/b.jpg"));

    }
}
