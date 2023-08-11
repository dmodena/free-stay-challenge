-- Commands needed to setup the PostgreSQL database for use with dbmate

-- Log into Postgres with privileged account using psql
-- `psql -U <user>`

-- create database
CREATE DATABASE $name;

-- create schema
CREATE SCHEMA $name;

-- create user
CREATE USER $name WITH PASSWORD '$password';

-- grant privileges
GRANT ALL ON DATABASE $db_name TO $user_name;
GRANT ALL ON SCHEMA $schema_name TO $user_name;

-- Add the connection string to an .env file for dbmate
-- Note: if you require SSL connection, check dbmate's documentation
--
-- # .env file
-- DATABASE_URL="postgres://user:password@host:port/db_name?search_path=schema_name&sslmode=disable"

-- Now you should be ready to use dbmate
-- `dbmate status`
-- `dbmate new <migration_name>`
-- `dbmate up | down`

-- Check dbmate documentation for more info at: https://github.com/amacneil/dbmate
