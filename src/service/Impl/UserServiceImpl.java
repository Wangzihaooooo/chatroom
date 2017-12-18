package service.Impl;

import org.springframework.stereotype.Service;
import persistence.domain.Result;
import persistence.domain.User;
import persistence.mapper.UserMapper;
import service.UserService;
import javax.annotation.Resource;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;

    @Override
    public void addUser(User user) {
        userMapper.insert(user);
    }

    @Override
    public void deleteUser(String userId) {
        userMapper.deleteByPrimaryKey(userId);
    }

    @Override
    public void updateUser(User user) {
        userMapper.updateByPrimaryKey(user);
    }

    @Override
    public User getUserById(String userId) {
        return userMapper.selectByPrimaryKey(userId);
    }

    @Override
    public User checkUser(String userName, String password) {
        User user=userMapper.selectByPrimaryKey(userName);
        if(user!=null&&user.getPassword().equals(password)){
            return user;
        }else {
            return null;
        }
    }

    @Override
    public Result checkRegisterUser(User user) {
        Result result=new Result();
        if(user.getUsername().equals("")){
            result.setStatus(Result.FAILURE);
            result.setMessage("用户名不能为空");
        }
        else if(user.getPassword().equals("")){
            result.setStatus(Result.FAILURE);
            result.setMessage("密码不能为空");
        }
        else if(userMapper.selectByPrimaryKey(user.getUsername())==null){
            userMapper.insert(user);
            result.setStatus(Result.SUCCESS);
            result.setMessage("注册成功");
        }else {
            result.setStatus(Result.FAILURE);
            result.setMessage("账号已经存在");
        }
        return result;
    }


}
