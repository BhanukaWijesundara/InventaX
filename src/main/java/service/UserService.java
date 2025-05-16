package service;

import model.User;
import util.FileHandler;
import java.util.List;

public class UserService {

    public void addUser(User user) {
        FileHandler.writeUser(user);
    }

    public List<User> getAllUsers() {
        return FileHandler.readUsers();
    }

    public void updateUser(List<User> users) {
        FileHandler.rewriteUsers(users);
    }

    public void deleteUser(String userId) {
        List<User> users = FileHandler.readUsers();
        users.removeIf(u -> u.getUserId().equals(userId));
        FileHandler.rewriteUsers(users);
    }
}