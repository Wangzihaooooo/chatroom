package service;


import persistence.domain.Result;
import persistence.domain.User;

/**
 * The interface User service.
 */
public interface UserService {
    /**
     * 添加用户
     *
     * @param user the user
     */
    void addUser(User user);

    /**
     * @param userId
     */
    void deleteUser(String userId);

    /**
     * @param user
     */
    void updateUser(User user);

    /**
     * 根据用户id获取用户
     *
     * @param userId the user id
     * @return user by id
     */
    User getUserById(String userId);

    /**
     * @param userName
     * @param password
     * @return
     */
    User checkUser(String userName,String password);

    /**
     * @param user
     * @return
     */
    Result checkRegisterUser(User user);
}
