package com.example.repository;

import com.example.model.User;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class UserRepository {
    
    private static final Logger logger = Logger.getLogger(UserRepository.class);
    
    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<User> userRowMapper = new RowMapper<User>() {
        @Override
        public User mapRow(ResultSet rs, int rowNum) throws SQLException {
            User user = new User();
            user.setId(rs.getLong("id"));
            user.setUsername(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setFullName(rs.getString("full_name"));
            
            Timestamp createdTimestamp = rs.getTimestamp("created_at");
            if (createdTimestamp != null) {
                user.setCreatedAt(createdTimestamp.toLocalDateTime());
            }
            
            Timestamp updatedTimestamp = rs.getTimestamp("updated_at");
            if (updatedTimestamp != null) {
                user.setUpdatedAt(updatedTimestamp.toLocalDateTime());
            }
            
            return user;
        }
    };

    public void createTable() {
        logger.info("사용자 테이블을 생성합니다.");
        String sql = "CREATE TABLE IF NOT EXISTS users (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY, " +
                "username VARCHAR(50) NOT NULL UNIQUE, " +
                "email VARCHAR(100) NOT NULL UNIQUE, " +
                "full_name VARCHAR(100) NOT NULL, " +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                ")";
        jdbcTemplate.execute(sql);
        logger.info("사용자 테이블 생성 완료");
    }

    public User save(User user) {
        logger.debug("사용자 저장: " + user.getUsername());
        
        if (user.getId() == null) {
            return insert(user);
        } else {
            return update(user);
        }
    }

    private User insert(User user) {
        String sql = "INSERT INTO users (username, email, full_name, created_at, updated_at) VALUES (?, ?, ?, ?, ?)";
        
        KeyHolder keyHolder = new GeneratedKeyHolder();
        
        jdbcTemplate.update(connection -> {
            PreparedStatement ps = connection.prepareStatement(sql, new String[]{"id"});
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getFullName());
            ps.setTimestamp(4, Timestamp.valueOf(LocalDateTime.now()));
            ps.setTimestamp(5, Timestamp.valueOf(LocalDateTime.now()));
            return ps;
        }, keyHolder);
        
        user.setId(keyHolder.getKey().longValue());
        logger.info("새 사용자 생성됨: ID=" + user.getId());
        return user;
    }

    private User update(User user) {
        String sql = "UPDATE users SET username=?, email=?, full_name=?, updated_at=? WHERE id=?";
        
        int updated = jdbcTemplate.update(sql, 
            user.getUsername(), 
            user.getEmail(), 
            user.getFullName(), 
            Timestamp.valueOf(LocalDateTime.now()),
            user.getId());
        
        if (updated > 0) {
            logger.info("사용자 정보 업데이트됨: ID=" + user.getId());
        } else {
            logger.warn("사용자 업데이트 실패: ID=" + user.getId());
        }
        
        return user;
    }

    public User findById(Long id) {
        logger.debug("ID로 사용자 조회: " + id);
        String sql = "SELECT * FROM users WHERE id = ?";
        List<User> users = jdbcTemplate.query(sql, userRowMapper, id);
        return users.isEmpty() ? null : users.get(0);
    }

    public User findByUsername(String username) {
        logger.debug("사용자명으로 조회: " + username);
        String sql = "SELECT * FROM users WHERE username = ?";
        List<User> users = jdbcTemplate.query(sql, userRowMapper, username);
        return users.isEmpty() ? null : users.get(0);
    }

    public List<User> findAll() {
        logger.debug("모든 사용자 조회");
        String sql = "SELECT * FROM users ORDER BY created_at DESC";
        return jdbcTemplate.query(sql, userRowMapper);
    }

    public void deleteById(Long id) {
        logger.info("사용자 삭제: ID=" + id);
        String sql = "DELETE FROM users WHERE id = ?";
        int deleted = jdbcTemplate.update(sql, id);
        if (deleted > 0) {
            logger.info("사용자 삭제 완료: ID=" + id);
        } else {
            logger.warn("삭제할 사용자 없음: ID=" + id);
        }
    }

    public long count() {
        String sql = "SELECT COUNT(*) FROM users";
        return jdbcTemplate.queryForObject(sql, Long.class);
    }
} 