package controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import persistence.domain.Result;
import persistence.domain.User;
import service.UserService;
import util.FileUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
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
            session.setAttribute("user",user);
        }
        return result;
    }
    @RequestMapping("/upload")
    @ResponseBody
    public String upload(HttpServletRequest request,
                       @RequestParam(value = "file", required = false) MultipartFile file,
                       RedirectAttributes attributes,
                         HttpSession session) throws Exception{
        if(!file.isEmpty()){
            // 上传文件路径 F:\idea\weixin\target\weixin-1.0-SNAPSHOT\speech
            String dirPath=System.getProperty("imagePath");;
            // 得到上传时的文件名
            String filename = file.getOriginalFilename();
            attributes.addAttribute("imageName",filename);
            // 判断父目录的路径是否存在，如果不存在就创建一个
            File filepath = new File(dirPath,filename);
            if (!filepath.getParentFile().exists()) {
                filepath.getParentFile().mkdirs(); }
            // 将上传文件保存到一个目标文件当中
            File imageFile=new File(dirPath+File.separator+ filename);
            //Runtime.getRuntime().exec("chmod 777 -R" + " "+dirPath+File.separator+filename);
            file.transferTo(imageFile);
            User user=(User)session.getAttribute("user");
            user.setImage("../img/"+filename);
            userService.updateUser(user);
        }
        return "cg";
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

        System.out.println(userService.getAllUser());
        User user=userService.checkUser(userName,passWord);
        Result result=new Result();
        if(user!=null){
            HttpSession session=request.getSession();
            session.setAttribute("user",user);
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
        User user=(User)session.getAttribute("user");
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
