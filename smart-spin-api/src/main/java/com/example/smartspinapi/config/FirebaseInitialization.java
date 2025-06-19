package com.example.smartspinapi.config;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.io.FileInputStream;
import java.io.IOException;

@Configuration
public class FirebaseInitialization {
    @Bean
    public FirebaseApp firebaseApp() throws IOException {
        FileInputStream serviceAccount =
                new FileInputStream("./serviceAccountKey.json");

        FirebaseOptions.Builder builder = FirebaseOptions.builder();

        FirebaseOptions options = builder.setCredentials(GoogleCredentials.fromStream(serviceAccount))
                .setDatabaseUrl("https://smart-spin-83f3e-default-rtdb.europe-west1.firebasedatabase.app")
                .build();

        return FirebaseApp.initializeApp(options);
    }

    @Bean
    public DatabaseReference firebaseDatabase(FirebaseApp app) {
        return FirebaseDatabase.getInstance(app).getReference();
    }
}
