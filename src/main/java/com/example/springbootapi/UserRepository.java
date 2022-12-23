package com.example.springbootapi;

import org.springframework.data.repository.CrudRepository;

//This will be auto implemented by Spring into a Bean called userRepository
//Crud repository refers to create, read, update and delete;

public interface UserRepository  extends CrudRepository<User, Integer> {
}