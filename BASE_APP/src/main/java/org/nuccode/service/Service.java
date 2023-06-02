package org.nuccode.service;

import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

@org.springframework.stereotype.Service
@Transactional
public class Service {
    public File createTempJavaFile(String code) throws IOException {
        File tempFile = File.createTempFile("UserCode", ".java");
        try (FileWriter writer = new FileWriter(tempFile)) {
            writer.write(code);
        }
        return tempFile;
    }
}
