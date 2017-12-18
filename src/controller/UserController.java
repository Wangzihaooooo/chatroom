package controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import persistence.domain.Result;
import persistence.domain.User;
import service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * The type User controller.
 */
@Controller
public class UserController {
    private static Logger log = Logger.getLogger(UserController.class.getName());
    //处理业务逻辑的userService
    @Resource
    private UserService userService;

    @RequestMapping("register")
    public String registerpage() {
        return "register";
    }

    @RequestMapping(value = "checkregister",method= RequestMethod.POST)
    @ResponseBody
    public Result checkRegister(User user,HttpServletRequest request,HttpServletResponse response) {
        Result result=userService.checkRegisterUser(user);
        if(result.getStatus().equals(Result.SUCCESS)) {
            HttpSession session=request.getSession();
            session.setAttribute("userSession",user);
        }
        return result;
    }

    @RequestMapping("/login")
    public String login() {
        return "login";
    }

    @RequestMapping(value = "/checklogin")
    @ResponseBody
    public Result checklogin(HttpServletRequest request,
                       ModelMap model,
                       @RequestParam("username") String userName,
                       @RequestParam("password") String passWord){

        User user=userService.checkUser(userName,passWord);
        Result result=new Result();
        if(user!=null){
            HttpSession session=request.getSession();
            session.setAttribute("userSession",user);
            result.setStatus(Result.SUCCESS);
            result.setMessage("登录成功");
        }else {
            result.setStatus(Result.FAILURE);
            result.setMessage("用户名或者密码错误");
        }
       return result;
    }

    @RequestMapping("/home")
    public ModelAndView home(ModelAndView modelAndView,
                             HttpSession session) {
        User user=(User)session.getAttribute("userSession");
        modelAndView.addObject(user);
        modelAndView.setViewName("home");
        return modelAndView;
    }

    //注销方法
    @RequestMapping("/outLogin")
    public String outLogin(HttpSession session){
        //通过session.invalidata()方法来注销当前的session
        session.invalidate();
        return "login";
    }
}
