package controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import persistence.domain.Record;
import persistence.domain.User;
import service.RecordService;
import service.UserService;
import util.HttpSessionConfigurator;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArraySet;
/**
  * @ServerEndpoint 注解是一个类层次的注解，它的功能主要是将目前的类定义成一个websocket服务器端,
  * 注解的值将被用于监听用户连接的终端访问URL地址,客户端可以通过这个URL来连接到WebSocket服务器端
  * 设定configurator，通过对ServerEndpointConfig.Configurator的继承，可以将一些request的属性或参数，放入WebSocket.Session中
  */
@ServerEndpoint(value = "/chatcontroller", configurator = HttpSessionConfigurator.class)
public class ChatController {
    @Resource
    private RecordService recordService;
    private static int  onlineCount  = 0; //静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
    //concurrent包的线程安全Set，用来存放每个客户端对应的WebSocket对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
    private static CopyOnWriteArraySet<ChatController> webSocketSet = new CopyOnWriteArraySet<ChatController>();
    private Session     session;    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private User         user;
    private HttpSession httpSession;    //request的session
    private static User all_user=new User();
    private static List list     = new ArrayList<User>();   //在线列表,记录用户名称
    private static Map  routetab = new HashMap<>();  //用户名和websocket的session绑定的路由表

    /**
     * 连接建立成功调用的方法
     * @param session  可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     */
    @OnOpen
    public void onOpen(Session session, EndpointConfig config){
        this.session = session;
        webSocketSet.add(this);     //加入set中
        addOnlineCount();           //在线数加1;
        this.httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
        this.user=(User) httpSession.getAttribute("userSession");    //获取当前用户
        all_user.setUsername("全体成员");
        if(! list.contains(all_user)){
            list.add(all_user);
        }
        list.add(user);           //将用户名加入在线列表
        routetab.put(user.getUsername(), session);   //将用户名和session绑定到路由表
        String message = getMessage("[" + user.getUsername() + "]加入聊天室,当前在线人数为"+getOnlineCount()+"位", "notice",  list);
        broadcast(message);     //广播
    }

    /**
     * 接收客户端的message,判断是否有接收人而选择进行广播还是指定发送
     * "massage" : {
     * "from" : "xxx",
     * "to" : "xxx",    n
     * "content" : "xxx",
     * "time" : "xxxx.xx.xx"
     *  },
     * "type" : {notice|message|image},
     * "list" : {[xx],[xx],[xx]}
     * @param _message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String _message) {
        JSONObject chat = JSON.parseObject(_message);
        JSONObject message = JSON.parseObject(chat.get("message").toString());
        Record record=new Record();
        record.setText(message.get("content").toString());
        record.setSender(message.get("from").toString());
        if(message.get("to") == null || message.get("to").equals("")){      //如果to为空,则广播;如果不为空,则对指定的用户发送消息
            httpSession.setAttribute("record",record);
            broadcast(_message);
        }else{
            String [] userlist = message.get("to").toString().split(",");
            record.setReceiver(message.get("to").toString());
            recordService.addRecord(record);
            singleSend(_message, (Session) routetab.get(message.get("from")));      //发送给自己,这个别忘了
            for(String user : userlist){
                if(!user.equals(message.get("from"))){
                    singleSend(_message, (Session) routetab.get(user));     //分别发送给每个指定用户
                }
            }
        }
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(){
        webSocketSet.remove(this);  //从set中删除
        subOnlineCount();           //在线数减1
        list.remove(user);        //从在线列表移除这个用户
        routetab.remove(user.getUsername());
        String message = getMessage("[" + user.getUsername() +"]离开了聊天室,当前在线人数为"+getOnlineCount()+"位", "notice", list);
        broadcast(message);         //广播
    }
    /**
     * 发生错误时调用
     * @param error
     */
    @OnError
    public void onError(Throwable error){
        error.printStackTrace();
    }

    /**
     * 广播消息
     * @param message
     */

    private void broadcast(String message){
        for(ChatController chat: webSocketSet){
            try {
                chat.session.getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();
                continue;
            }
        }
    }

    /**
     * 对特定用户发送消息
     * @param message
     * @param session
     */
    private void singleSend(String message, Session session){
        try {
            session.getBasicRemote().sendText(message);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 组装返回给前台的消息
     * @param message   交互信息
     * @param type      信息类型
     * @param list      在线列表
     * @return
     */
    private String getMessage(String message, String type, List list){
        JSONObject member = new JSONObject();
        member.put("message", message);
        member.put("type", type);
        member.put("list", list);
        return member.toString();
    }

    private   int getOnlineCount() {
        return onlineCount;
    }

    private   void addOnlineCount() {
        ChatController.onlineCount++;
    }

    private   void subOnlineCount() {
        ChatController.onlineCount--;
    }
}
