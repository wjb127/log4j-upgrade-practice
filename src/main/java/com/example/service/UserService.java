package com.example.service;

import com.example.model.User;
import com.example.repository.UserRepository;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;


import java.util.List;

@Service
@Transactional
public class UserService {

    private static final Logger logger = Logger.getLogger(UserService.class);

    @Autowired
    private UserRepository userRepository;

    @PostConstruct
    public void init() {
        logger.info("UserService 초기화 중...");
        userRepository.createTable();
        
        // 샘플 데이터 추가
        if (userRepository.count() == 0) {
            createSampleUsers();
        }
    }

    private void createSampleUsers() {
        logger.info("샘플 사용자 데이터 생성");
        
        User user1 = new User("admin", "admin@example.com", "관리자");
        User user2 = new User("user1", "user1@example.com", "홍길동");
        User user3 = new User("user2", "user2@example.com", "김철수");
        
        save(user1);
        save(user2);
        save(user3);
        
        logger.info("샘플 데이터 생성 완료");
    }

    public User save(User user) {
        logger.info("사용자 저장 요청: " + user.getUsername());
        
        // 중복 검사
        if (user.getId() == null) {
            User existingUser = userRepository.findByUsername(user.getUsername());
            if (existingUser != null) {
                logger.warn("이미 존재하는 사용자명: " + user.getUsername());
                throw new RuntimeException("이미 존재하는 사용자명입니다: " + user.getUsername());
            }
        }
        
        User savedUser = userRepository.save(user);
        logger.info("사용자 저장 완료: " + savedUser.getId());
        return savedUser;
    }

    @Transactional(readOnly = true)
    public User findById(Long id) {
        logger.debug("ID로 사용자 조회 요청: " + id);
        User user = userRepository.findById(id);
        if (user == null) {
            logger.warn("사용자를 찾을 수 없음: ID=" + id);
        }
        return user;
    }

    @Transactional(readOnly = true)
    public User findByUsername(String username) {
        logger.debug("사용자명으로 조회 요청: " + username);
        return userRepository.findByUsername(username);
    }

    @Transactional(readOnly = true)
    public List<User> findAll() {
        logger.debug("전체 사용자 목록 조회");
        List<User> users = userRepository.findAll();
        logger.info("조회된 사용자 수: " + users.size());
        return users;
    }

    public void deleteById(Long id) {
        logger.info("사용자 삭제 요청: ID=" + id);
        User user = userRepository.findById(id);
        if (user == null) {
            logger.warn("삭제할 사용자를 찾을 수 없음: ID=" + id);
            throw new RuntimeException("사용자를 찾을 수 없습니다: ID=" + id);
        }
        
        userRepository.deleteById(id);
        logger.info("사용자 삭제 완료: " + user.getUsername());
    }

    @Transactional(readOnly = true)
    public long getTotalCount() {
        long count = userRepository.count();
        logger.debug("전체 사용자 수: " + count);
        return count;
    }

    public User updateUser(Long id, User userDetails) {
        logger.info("사용자 정보 업데이트 요청: ID=" + id);
        
        User existingUser = userRepository.findById(id);
        if (existingUser == null) {
            logger.warn("업데이트할 사용자를 찾을 수 없음: ID=" + id);
            throw new RuntimeException("사용자를 찾을 수 없습니다: ID=" + id);
        }

        existingUser.setUsername(userDetails.getUsername());
        existingUser.setEmail(userDetails.getEmail());
        existingUser.setFullName(userDetails.getFullName());
        
        return userRepository.save(existingUser);
    }
} 