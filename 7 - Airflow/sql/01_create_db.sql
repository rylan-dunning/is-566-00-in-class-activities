CREATE SCHEMA IF NOT EXISTS cryptodata;

CREATE TABLE IF NOT EXISTS cryptodata.ASSETS (
    asset_id SERIAL PRIMARY KEY,
    id VARCHAR(255),
    rank INT,
    symbol VARCHAR(10),
    name VARCHAR(255),
    supply NUMERIC(40, 20),
    maxSupply NUMERIC(40, 20),
    marketCapUsd NUMERIC(40, 20),
    volumeUsd24Hr NUMERIC(40, 20),
    priceUsd NUMERIC(40, 20),
    changePercent24Hr NUMERIC(40, 20),
    vwap24Hr NUMERIC(40, 20),
    explorer TEXT,
    timestamp TIMESTAMP
);

CREATE TABLE IF NOT EXISTS cryptodata.historical_asset_pricing (
    asset_id VARCHAR(255) NOT NULL,
    priceUsd NUMERIC(40, 20) NOT NULL,
    time BIGINT NOT NULL,
    date DATE NOT NULL,
    PRIMARY KEY (asset_id, time)
);

CREATE TABLE IF NOT EXISTS cryptodata.timelog (
    log_id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP DEFAULT NOW(),
    session_id VARCHAR(255) NOT NULL,
    message VARCHAR(500) NOT NULL
);
