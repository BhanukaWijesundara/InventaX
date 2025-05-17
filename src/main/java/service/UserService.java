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

    public boolean isUsernameExists(String username) {
        List<User> users = getAllUsers();
        return users.stream().anyMatch(user -> user.getUsername().equals(username));
    }

    public User validateUser(String username, String password) {
        List<User> users = getAllUsers();
        return users.stream()
                .filter(user -> user.getUsername().equals(username) && user.getPassword().equals(password))
                .findFirst()
                .orElse(null);
    }
}