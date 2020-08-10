package com.unittest;

import javax.jws.WebService;
import javax.xml.ws.Endpoint;

@WebService
public class HelloWorldService {
    public String sayHello(String name){
        return "Hello " + name + "!";
    }

    public static void main(String[] args) {
        Endpoint.publish("http://192.168.1.5:8888/helloWorld", new HelloWorldService());
        System.out.println("发布成功！");
    }
}
