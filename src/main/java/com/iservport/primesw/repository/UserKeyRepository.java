package com.iservport.primesw.repository;

import java.io.Serializable;

import org.helianto.core.domain.KeyType;
import org.helianto.user.domain.UserKey;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserKeyRepository extends JpaRepository<UserKey, Serializable> {

	UserKey findByUserGroup_IdAndKeyType(Integer userId, KeyType keyType);
	
}
