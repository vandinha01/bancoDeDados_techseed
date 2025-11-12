-- Criação do banco de dados Seed Tech
CREATE DATABASE IF NOT EXISTS seed_tech;
USE seed_tech;

-- Tabela para armazenar informações sobre os armazéns/silos
CREATE TABLE IF NOT EXISTS armazens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    localizacao VARCHAR(255),
    capacidade_kg DECIMAL(10, 2)
);

-- Tabela para armazenar informações sobre os dispositivos ESP32
CREATE TABLE IF NOT EXISTS esp32_dispositivos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    armazem_id INT,
    status VARCHAR(50) DEFAULT 'ativo',
    FOREIGN KEY (armazem_id) REFERENCES armazens(id)
);

-- Tabela para sensores DHT22 (Temperatura e Umidade)
CREATE TABLE IF NOT EXISTS dht22_sensores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    esp32_dispositivo_id INT NOT NULL,
    localizacao_detalhada VARCHAR(255),
    FOREIGN KEY (esp32_dispositivo_id) REFERENCES esp32_dispositivos(id)
);

-- Tabela para dados de sensores DHT22
CREATE TABLE IF NOT EXISTS dht22_dados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dht22_sensor_id INT NOT NULL,
    temperatura DECIMAL(5, 2), -- Em Celsius
    umidade DECIMAL(5, 2),    -- Umidade relativa do ar em %
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dht22_sensor_id) REFERENCES dht22_sensores(id)
);

-- Tabela para sensores LDR (Luminosidade)
CREATE TABLE IF NOT EXISTS ldr_sensores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    esp32_dispositivo_id INT NOT NULL,
    localizacao_detalhada VARCHAR(255),
    FOREIGN KEY (esp32_dispositivo_id) REFERENCES esp32_dispositivos(id)
);

-- Tabela para dados de sensores LDR
CREATE TABLE IF NOT EXISTS ldr_dados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ldr_sensor_id INT NOT NULL,
    luminosidade DECIMAL(10, 2), -- Em Lux
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ldr_sensor_id) REFERENCES ldr_sensores(id)
);

-- Tabela para sensores Ultrassônicos (Impacto/Distância)
CREATE TABLE IF NOT EXISTS ultrassonico_sensores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    esp32_dispositivo_id INT NOT NULL,
    localizacao_detalhada VARCHAR(255),
    FOREIGN KEY (esp32_dispositivo_id) REFERENCES esp32_dispositivos(id)
);

-- Tabela para dados de sensores Ultrassônicos
CREATE TABLE IF NOT EXISTS ultrassonico_dados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ultrassonico_sensor_id INT NOT NULL,
    distancia DECIMAL(10, 2), -- Em cm, ou similar, para detectar impacto
    impacto BOOLEAN, -- 1 para impacto detectado, 0 para nenhum impacto (pode ser derivado da distância)
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ultrassonico_sensor_id) REFERENCES ultrassonico_sensores(id)
);

