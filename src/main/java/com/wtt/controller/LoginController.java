package com.wtt.controller;

import com.wtt.bean.Msg;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
public class LoginController {

    /**
     * 登录的用户名：admin，密码1234
     * @param request
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/dologin", method = RequestMethod.POST)
    public Msg dologin(HttpServletRequest request){
        String str = request.getParameter("username")+request.getParameter("password");
        if (!str.equals("admin1234")){
            System.out.println(str);
            return Msg.fail().add("login_error","输入账号用户名与密码不匹配");
        }
        return Msg.success();
    }

    /**
     * 跳转到主页面
     * @return
     */
    @RequestMapping(value = "/main",method = RequestMethod.GET)
    public String main(){
        return "main";
    }
}
