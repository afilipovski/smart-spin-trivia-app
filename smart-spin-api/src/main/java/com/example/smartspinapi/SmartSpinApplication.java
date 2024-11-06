package com.example.smartspinapi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.File;
import java.util.Objects;
import java.util.Scanner;

@SpringBootApplication
public class SmartSpinApplication {

    public static void main(String[] args) {
        SpringApplication.run(SmartSpinApplication.class, args);
        if (System.getenv("ONLY_CREATE_MIGRATIONS") != null) {
            System.out.println("Migration name:");
            Scanner s = new Scanner(System.in);
            String migrationName = s.nextLine().toLowerCase().replace(' ', '_');
            File latestMigration = new File("create.sql");
            File folder = new File("./src/main/resources/db/migration");
            int nextNumber = Objects.requireNonNull(folder.listFiles()).length + 1;
            latestMigration.renameTo(new File("./src/main/resources/db/migration/V" + nextNumber + "__" + migrationName + ".sql"));
            System.exit(0);
        }
    }

}
