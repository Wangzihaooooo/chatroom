/*
package interceptor;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.sun.jmx.snmp.Timestamp;
import controller.ChatController;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;
import persistence.domain.Record;
import persistence.domain.User;
import service.RecordService;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.CopyOnWriteArraySet;


@Component
public class WebSocketInterceptor implements WebSocketHandler {
    @Resource
    private RecordService recordService;
    private static int                                 onlineCount  = 0; //静态变量，用来记录当前在线连接数。应该把它设计成线程安全的。
    //concurrent包的线程安全Set，用来存放每个客户端对应的WebSocket对象。若要实现服务端与单一客户端通信的话，可以使用Map来存放，其中Key可以为用户标识
    private static CopyOnWriteArraySet<ChatController> webSocketSet = new CopyOnWriteArraySet<ChatController>();
    private Session     session;    //与某个客户端的连接会话，需要通过它来给客户端发送数据
    private User        user;
    private HttpSession httpSession;    //request的session
    private static User all_user =new User();
    private static List list     = new ArrayList<User>();   //在线列表,记录用户名称
    private static Map  routetab = new HashMap<>();  //用户名和websocket的session绑定的路由表

    //当MyWebSocketHandler类被加载时就会创建该Map，随类而生
    public static final Map<String, WebSocketSession> userSocketSessionMap;

    static {
        userSocketSessionMap = new HashMap<String, WebSocketSession>();
    }

    //握手实现连接后
    @Override
    public void afterConnectionEstablished(WebSocketSession webSocketSession) throws Exception {
        String username = (String) webSocketSession.getAttributes().get("username");
        if (userSocketSessionMap.get(username) == null) {
            userSocketSessionMap.put(username, webSocketSession);
        }
    }

    //发送信息前的处理
    @Override
    public void handleMessage(WebSocketSession webSocketSession, WebSocketMessage<?> webSocketMessage) throws Exception {

        if(webSocketMessage.getPayloadLength()==0)return;

        //得到Socket通道中的数据并转化为Message对象
        String _message=webSocketMessage.getPayload().toString();
        JSONObject chat = JSON.parseObject(_message);
        JSONObject message = JSON.parseObject(chat.get("message").toString());
        Record record=new Record();
        record.setText(message.get("content").toString());
        record.setSender(message.get("from").toString());
        Timestamp now = new Timestamp(System.currentTimeMillis());
        //将信息保存至数据库
        recordService.addRecord(record);

        //发送Socket信息
        //sendMessageToUser(record.getReceiver(), new TextMessage(new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(msg)));
    }
    @Override
    public void handleTransportError(WebSocketSession webSocketSession, Throwable throwable) throws Exception {

    }

    */
/**
     * 在此刷新页面就相当于断开WebSocket连接,原本在静态变量userSocketSessionMap中的
     * WebSocketSession会变成关闭状态(close)，但是刷新后的第二次连接服务器创建的
     * 新WebSocketSession(open状态)又不会加入到userSocketSessionMap中,所以这样就无法发送消息
     * 因此应当在关闭连接这个切面增加去除userSocketSessionMap中当前处于close状态的WebSocketSession，
     * 让新创建的WebSocketSession(open状态)可以加入到userSocketSessionMap中
     * @param webSocketSession
     * @param closeStatus
     * @throws Exception
     *//*

    @Override
    public void afterConnectionClosed(WebSocketSession webSocketSession, CloseStatus closeStatus) throws Exception {

        System.out.println("WebSocket:"+webSocketSession.getAttributes().get("username")+"close connection");
        Iterator<Map.Entry<String,WebSocketSession>> iterator = userSocketSessionMap.entrySet().iterator();
        while(iterator.hasNext()){
            Map.Entry<String,WebSocketSession> entry = iterator.next();
            if(entry.getValue().getAttributes().get("username").equals(webSocketSession.getAttributes().get("username"))){
                userSocketSessionMap.remove(webSocketSession.getAttributes().get("username"));
                System.out.println("WebSocket in staticMap:" + webSocketSession.getAttributes().get("username") + "removed");
            }
        }
    }
    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    //发送信息的实现
    public void sendMessageToUser(String uid, TextMessage message)
            throws IOException {
        WebSocketSession session = userSocketSessionMap.get(uid);
        if (session != null && session.isOpen()) {
            session.sendMessage(message);
        }
    }
}
*/
