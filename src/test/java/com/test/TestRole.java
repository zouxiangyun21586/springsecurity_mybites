package com.test;

import org.junit.Test;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;

public class TestRole extends SpringTestCase {
	
	@Test
	public void testPassword(){
		PasswordEncoder passwordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		String encoded = passwordEncoder.encode("123456");
		System.err.println(encoded);
	}
	
}
