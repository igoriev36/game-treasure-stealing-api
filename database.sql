-- -------------------------------------------------------------
-- TablePlus 3.6.2(322)
--
-- https://tableplus.com/
--
-- Database: game_treasure_stealing
-- Generation Time: 2022-07-04 01:58:36.7580
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."admins";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS admins_id_seq;

-- Table Definition
CREATE TABLE "public"."admins" (
    "id" int8 NOT NULL DEFAULT nextval('admins_id_seq'::regclass),
    "username" varchar(100) NOT NULL,
    "email" varchar(150) NOT NULL,
    "password" varchar(150) NOT NULL,
    "active" int2,
    "avatar_url" varchar(255),
    "display_name" varchar(255),
    "created_at" timestamp(0),
    "updated_at" timestamp(0),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."auth_refresh_tokens";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Table Definition
CREATE TABLE "public"."auth_refresh_tokens" (
    "id" varchar(100) NOT NULL DEFAULT NULL::character varying,
    "token" text NOT NULL,
    "data" text NOT NULL,
    "expires_at" timestamp(0)
);

DROP TABLE IF EXISTS "public"."game_playing";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS games_play_id_seq;

-- Table Definition
CREATE TABLE "public"."game_playing" (
    "id" int8 NOT NULL DEFAULT nextval('games_play_id_seq'::regclass),
    "user_id" int8 NOT NULL,
    "game_id" int8 NOT NULL,
    "data" json NOT NULL,
    "won" int2,
    "bonus" int2,
    "note" text,
    "heroes" jsonb,
    "finished" int2,
    "winning_hero" varchar(100),
    "created_at" timestamp(0),
    "updated_at" timestamp(0),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."game_transactions";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS game_transactions_id_seq;

-- Table Definition
CREATE TABLE "public"."game_transactions" (
    "id" int8 NOT NULL DEFAULT nextval('game_transactions_id_seq'::regclass),
    "type" varchar(50) NOT NULL,
    "amount" float8 NOT NULL,
    "event" varchar(255) NOT NULL,
    "user_id" int8,
    "description" text,
    "uid" varchar(50),
    "game_playing_id" int8,
    "created_at" timestamp(0),
    "updated_at" timestamp(0),
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."games";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS games_id_seq;

-- Table Definition
CREATE TABLE "public"."games" (
    "id" int8 NOT NULL DEFAULT nextval('games_id_seq'::regclass),
    "data" json,
    "result" varchar(30),
    "back_pot" float8,
    "end" int2,
    "note" text,
    "raked" float8,
    "created_at" timestamp(0),
    "updated_at" timestamp(0),
    "thieves_count" int4,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."hero_tier_tickets";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS hero_tier_tickets_id_seq;

-- Table Definition
CREATE TABLE "public"."hero_tier_tickets" (
    "id" int8 NOT NULL DEFAULT nextval('hero_tier_tickets_id_seq'::regclass),
    "tier" varchar(100),
    "tickets" int4,
    "tix_from_stats" int4,
    "ev_class" float8,
    "post_rake_ev" float8,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."heroes";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS heroes_id_seq;

-- Table Definition
CREATE TABLE "public"."heroes" (
    "id" int8 NOT NULL DEFAULT nextval('heroes_id_seq'::regclass),
    "mint" varchar(100),
    "user_id" int8,
    "active" int2,
    "extra_data" json,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."options";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS options_id_seq;

-- Table Definition
CREATE TABLE "public"."options" (
    "id" int4 NOT NULL DEFAULT nextval('options_id_seq'::regclass),
    "option_name" varchar(200) NOT NULL,
    "option_value" text NOT NULL,
    "autoload" bool NOT NULL DEFAULT true,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."quantity_lookup";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS quantity_lookup_id_seq;

-- Table Definition
CREATE TABLE "public"."quantity_lookup" (
    "id" int8 NOT NULL DEFAULT nextval('quantity_lookup_id_seq'::regclass),
    "type" varchar(30),
    "quantity_from" int4,
    "value" float8,
    PRIMARY KEY ("id")
);

DROP TABLE IF EXISTS "public"."usermeta";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS usermeta_id_seq;

-- Table Definition
CREATE TABLE "public"."usermeta" (
    "umeta_id" int8 NOT NULL DEFAULT nextval('usermeta_id_seq'::regclass),
    "user_id" int8 NOT NULL,
    "meta_key" varchar(200) NOT NULL,
    "meta_value" text NOT NULL,
    PRIMARY KEY ("umeta_id")
);

DROP TABLE IF EXISTS "public"."users";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS users_id_seq;

-- Table Definition
CREATE TABLE "public"."users" (
    "id" int8 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    "fullname" varchar(200),
    "wallet_address" varchar(100) NOT NULL,
    "password" varchar(150) NOT NULL,
    "email" varchar(150),
    "email_verified_at" timestamp(0),
    "balance" float8,
    "total_loot" float8,
    "total_loot_won" float8,
    "loose_loost" float8,
    "active" int2,
    "avatar_url" varchar(255),
    "uid" varchar(80) NOT NULL,
    "created_at" timestamp(0),
    "updated_at" timestamp(0),
    PRIMARY KEY ("id")
);

INSERT INTO "public"."admins" ("id", "username", "email", "password", "active", "avatar_url", "display_name", "created_at", "updated_at") VALUES
('1', 'admin', 'tai.ictu@gmail.com', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', '1', '', '', '2022-07-04 00:20:46', '2022-07-04 00:20:46');

INSERT INTO "public"."auth_refresh_tokens" ("id", "token", "data", "expires_at") VALUES
('e3b87dfc-231f-4280-91b9-8aa10c5f76b0', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiJlM2I4N2RmYy0yMzFmLTQyODAtOTFiOS04YWExMGM1Zjc2YjAiLCJpYXQiOjE2NTU0MzgwMTMsImV4cCI6MTY1NjA0MjgxM30.lG7r9Fmm_PHJSAOGRBBtX2QzCICGzR9FIcZ8srPtZMY', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"e3b87dfc-231f-4280-91b9-8aa10c5f76b0"}', '2022-06-24 03:53:33'),
('b5ee09ae-6a1b-4aa0-a02b-be228074aa70', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiJiNWVlMDlhZS02YTFiLTRhYTAtYTAyYi1iZTIyODA3NGFhNzAiLCJpYXQiOjE2NTU0NTMzNDgsImV4cCI6MTY1NjA1ODE0OH0.SbY0FyufuZJQ9dG6ccdfl5q_8NMv_W9_JMtHRlHSyj0', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"b5ee09ae-6a1b-4aa0-a02b-be228074aa70"}', '2022-06-23 20:09:08'),
('61531d33-8d63-43a1-bb19-96b08d9514dc', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiI2MTUzMWQzMy04ZDYzLTQzYTEtYmIxOS05NmIwOGQ5NTE0ZGMiLCJpYXQiOjE2NTU0NTMzNzAsImV4cCI6MTY1NjA1ODE3MH0.zPc_sGcouZlLnM2iYlfdrcbxjzvrLlPG9haW9L8RgdU', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"61531d33-8d63-43a1-bb19-96b08d9514dc"}', '2022-06-23 20:09:30'),
('e39d0ede-7780-44cc-8278-20b6657b51f8', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiJlMzlkMGVkZS03NzgwLTQ0Y2MtODI3OC0yMGI2NjU3YjUxZjgiLCJpYXQiOjE2NTU0NTc5MzcsImV4cCI6MTY1NjA2MjczN30.VHw9T3coJ0ikqBfuRVnUz_rA3T6lFlI_0nkIC4ysgPM', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"e39d0ede-7780-44cc-8278-20b6657b51f8"}', '2022-06-23 21:25:37'),
('423c5748-09ba-46f5-a571-9ce7ad7574de', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiI0MjNjNTc0OC0wOWJhLTQ2ZjUtYTU3MS05Y2U3YWQ3NTc0ZGUiLCJpYXQiOjE2NTU0NjYxMDYsImV4cCI6MTY1NjA3MDkwNn0.s3cda-YWacVp73jUNto6t12RXC6Pg_m_5R0JyrPKsVw', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"423c5748-09ba-46f5-a571-9ce7ad7574de"}', '2022-06-23 23:41:46'),
('dfc5625f-32aa-4e50-99d3-f08a949af363', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiJkZmM1NjI1Zi0zMmFhLTRlNTAtOTlkMy1mMDhhOTQ5YWYzNjMiLCJpYXQiOjE2NTU0NjYzMjQsImV4cCI6MTY1NjA3MTEyNH0.NnZW4Eo2Y9jNsF3F4kyJSdR26F1niYuY50TZL-RW6M4', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"dfc5625f-32aa-4e50-99d3-f08a949af363"}', '2022-06-23 23:45:24'),
('4a4f5626-5f15-4585-b71e-b60259474078', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiI0YTRmNTYyNi01ZjE1LTQ1ODUtYjcxZS1iNjAyNTk0NzQwNzgiLCJpYXQiOjE2NTU0NjY0MTYsImV4cCI6MTY1NjA3MTIxNn0.kz4lNuuxEbD8uS5UIxBiYmmt8yOaqlr0-d5laXrgomk', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"4a4f5626-5f15-4585-b71e-b60259474078"}', '2022-06-23 23:46:56'),
('e92691d8-0455-4196-9a4c-e5f4e289c1ff', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiJlOTI2OTFkOC0wNDU1LTQxOTYtOWE0Yy1lNWY0ZTI4OWMxZmYiLCJpYXQiOjE2NTU0NjY0NTUsImV4cCI6MTY1NjA3MTI1NX0.ObL6oGKdOFYd59SKWf-8fJmTMXnacMgpbiydu1cvfN0', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"e92691d8-0455-4196-9a4c-e5f4e289c1ff"}', '2022-06-23 23:47:35'),
('b30e4f28-cd68-4e9e-ad91-4e05d0095dac', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiJiMzBlNGYyOC1jZDY4LTRlOWUtYWQ5MS00ZTA1ZDAwOTVkYWMiLCJpYXQiOjE2NTU0NjY2MzcsImV4cCI6MTY1NjA3MTQzN30.31dYi8mep9o_J3rapYs3Is5AlXWB-fLqaHhSs2Tbqyw', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"b30e4f28-cd68-4e9e-ad91-4e05d0095dac"}', '2022-06-23 23:50:37'),
('2ddeda3c-187a-48f7-a313-e2997498fd9f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiIyZGRlZGEzYy0xODdhLTQ4ZjctYTMxMy1lMjk5NzQ5OGZkOWYiLCJpYXQiOjE2NTU0NjY3MDYsImV4cCI6MTY1NjA3MTUwNn0.1wuw-NptrMdzOC39bOUJOKj4QpR5m1IODYzL_vDX7Ho', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"2ddeda3c-187a-48f7-a313-e2997498fd9f"}', '2022-06-23 23:51:46'),
('85e199f5-8429-4b5d-939b-6a5fd140ac16', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiI4NWUxOTlmNS04NDI5LTRiNWQtOTM5Yi02YTVmZDE0MGFjMTYiLCJpYXQiOjE2NTU0Njc1NTAsImV4cCI6MTY1NjA3MjM1MH0.5tXbaAGc3kldrgryTgAUrSTN8duhvw0EA6RY43E-AMo', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"85e199f5-8429-4b5d-939b-6a5fd140ac16"}', '2022-06-24 00:05:50'),
('b961336e-c32e-43cd-a139-6b0d9e174f84', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiJiOTYxMzM2ZS1jMzJlLTQzY2QtYTEzOS02YjBkOWUxNzRmODQiLCJpYXQiOjE2NTU0Njc3MDEsImV4cCI6MTY1NjA3MjUwMX0.LOiGrA6XYWC5UOdsJiXNJTr8CLdTxwmtBKRjAU_nW6k', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"b961336e-c32e-43cd-a139-6b0d9e174f84"}', '2022-06-24 00:08:21'),
('ffc0c657-4835-4eaf-a0c6-80fa48243655', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiJmZmMwYzY1Ny00ODM1LTRlYWYtYTBjNi04MGZhNDgyNDM2NTUiLCJpYXQiOjE2NTU0Njc3MDcsImV4cCI6MTY1NjA3MjUwN30.fTl-8Ii7NKssGdGIhrkzkWiSb3oDzYNivV9uhJHbiNc', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"ffc0c657-4835-4eaf-a0c6-80fa48243655"}', '2022-06-24 00:08:27'),
('b739c177-90c8-4957-9dae-9f164a02331b', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiJiNzM5YzE3Ny05MGM4LTQ5NTctOWRhZS05ZjE2NGEwMjMzMWIiLCJpYXQiOjE2NTU0Njc3MjMsImV4cCI6MTY1NjA3MjUyM30.prpOQKEy6Zin4J2ehuYr4z_HMwLjWLD87fVptEcXawM', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"b739c177-90c8-4957-9dae-9f164a02331b"}', '2022-06-24 00:08:43'),
('75f223e5-81e7-4f99-bd2a-8988fd3b3210', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiI3NWYyMjNlNS04MWU3LTRmOTktYmQyYS04OTg4ZmQzYjMyMTAiLCJpYXQiOjE2NTU0Njc5NTYsImV4cCI6MTY1NjA3Mjc1Nn0.O_Rga5yQ0MHafibomxxyWb1xw71ZnuMhWzcgw8kYVVo', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"75f223e5-81e7-4f99-bd2a-8988fd3b3210"}', '2022-06-24 00:12:36'),
('93080f27-5922-42c8-b774-626480867379', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiI5MzA4MGYyNy01OTIyLTQyYzgtYjc3NC02MjY0ODA4NjczNzkiLCJpYXQiOjE2NTU0NjgwNTYsImV4cCI6MTY1NjA3Mjg1Nn0.pJfMQFV-TdQtt7w_IGNsezlWN5WXV8uQHMSX0ss_NTg', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"93080f27-5922-42c8-b774-626480867379"}', '2022-06-24 00:14:16'),
('af905d3e-1f1c-433a-9f93-b093d33c2ad4', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiJhZjkwNWQzZS0xZjFjLTQzM2EtOWY5My1iMDkzZDMzYzJhZDQiLCJpYXQiOjE2NTU0NjgyMDMsImV4cCI6MTY1NjA3MzAwM30.9SFAkGp-52OKOWbTzFtE5sTrz0bU9qBCGCVdejkcgx0', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"af905d3e-1f1c-433a-9f93-b093d33c2ad4"}', '2022-06-24 00:16:43'),
('3b489fe4-1091-47b8-b05d-b25643eff9f1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiIzYjQ4OWZlNC0xMDkxLTQ3YjgtYjA1ZC1iMjU2NDNlZmY5ZjEiLCJpYXQiOjE2NTU0NjgyMjAsImV4cCI6MTY1NjA3MzAyMH0.2wZoz9q-sY8JQQPgcAiL4cetrnMQaK6jwbOdfLUTWPE', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"3b489fe4-1091-47b8-b05d-b25643eff9f1"}', '2022-06-24 00:17:00'),
('cb9b0995-573e-4716-92a7-6d49e466bf90', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiJjYjliMDk5NS01NzNlLTQ3MTYtOTJhNy02ZDQ5ZTQ2NmJmOTAiLCJpYXQiOjE2NTU0NjgzNzEsImV4cCI6MTY1NjA3MzE3MX0.mu-NQFmln8tOmmBks-vE94SYP6Q-Elm77ecB00JY4As', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"cb9b0995-573e-4716-92a7-6d49e466bf90"}', '2022-06-24 00:19:31'),
('25bc2c09-ec96-4f0c-a218-79ff7c1980f6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiIyNWJjMmMwOS1lYzk2LTRmMGMtYTIxOC03OWZmN2MxOTgwZjYiLCJpYXQiOjE2NTU0NjgzNzksImV4cCI6MTY1NjA3MzE3OX0.JCg8ZUU3QfHa9qhjXWAWNPuDsxmi4lxZLh88X2fkOkU', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"25bc2c09-ec96-4f0c-a218-79ff7c1980f6"}', '2022-06-24 00:19:39'),
('82361d88-eb15-418e-a7d1-b139d2730b56', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiI4MjM2MWQ4OC1lYjE1LTQxOGUtYTdkMS1iMTM5ZDI3MzBiNTYiLCJpYXQiOjE2NTU0Njg2NjYsImV4cCI6MTY1NjA3MzQ2Nn0.KP-7RjV8CYtNMGe7bOwWiefzkoGAm6SeuGiICgZmqNc', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"82361d88-eb15-418e-a7d1-b139d2730b56"}', '2022-06-24 00:24:26'),
('53924781-64a2-4b94-82c6-50a547151b3f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsImVtYWlsIjoidGFpLmljdHVAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJhY3RpdmUiOjEsInNvbF9iYWxhbmNlIjowLCJsb290X3RvdGFsIjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYNiIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTE3VDAzOjA5OjQ1LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidG9rZW5faWQiOiI1MzkyNDc4MS02NGEyLTRiOTQtODJjNi01MGE1NDcxNTFiM2YiLCJpYXQiOjE2NTU0Njg4MDIsImV4cCI6MTY1NjA3MzYwMn0.tLz-BROfbGmlMdEfjDJIM_qbif7TZnVa1hgCEabYlWU', '{"id":"1","fullname":"Be Tai","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"53924781-64a2-4b94-82c6-50a547151b3f"}', '2022-06-24 00:26:42'),
('69af2ddb-7cda-4484-8d83-dcd6bf94e886', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwibG9vdF90b3RhbCI6MCwiYXZhdGFyX3VybCI6bnVsbCwidWlkIjoiNmN3YVFUWDYiLCJjcmVhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjItMDYtMTdUMDM6MDk6NDUuMDAwWiIsInRva2VuX2lkIjoiNjlhZjJkZGItN2NkYS00NDg0LThkODMtZGNkNmJmOTRlODg2IiwiaWF0IjoxNjU1NDY5MTc0LCJleHAiOjE2NTYwNzM5NzR9.x4j4OPgMETixwlPSYZf1xfw-nUvsO_QOTnBTmwb3hBk', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"69af2ddb-7cda-4484-8d83-dcd6bf94e886"}', '2022-06-24 00:32:54'),
('552ec7c2-0625-4f88-a595-33532ba3b753', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwibG9vdF90b3RhbCI6MCwiYXZhdGFyX3VybCI6bnVsbCwidWlkIjoiNmN3YVFUWDYiLCJjcmVhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjItMDYtMTdUMDM6MDk6NDUuMDAwWiIsInRva2VuX2lkIjoiNTUyZWM3YzItMDYyNS00Zjg4LWE1OTUtMzM1MzJiYTNiNzUzIiwiaWF0IjoxNjU1NjI5NjYxLCJleHAiOjE2NTYyMzQ0NjF9.OYjRA58LFcLY9KGPQ6_OP_QHsJtrylQGs4rBKXU5OMA', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"552ec7c2-0625-4f88-a595-33532ba3b753"}', '2022-06-25 21:07:41'),
('69056e31-d5b7-4abf-8317-a189586d45d5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwibG9vdF90b3RhbCI6MCwiYXZhdGFyX3VybCI6bnVsbCwidWlkIjoiNmN3YVFUWDYiLCJjcmVhdGVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjItMDYtMTdUMDM6MDk6NDUuMDAwWiIsInRva2VuX2lkIjoiNjkwNTZlMzEtZDViNy00YWJmLTgzMTctYTE4OTU4NmQ0NWQ1IiwiaWF0IjoxNjU1NjMwOTMzLCJleHAiOjE2NTYyMzU3MzN9.u3OmuJa8KJp9NgGMuUgxiwAsBOXEg9rFip31aC_W9JU', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"loot_total":0,"avatar_url":null,"uid":"6cwaQTX6","created_at":"2022-06-17T03:09:45.000Z","updated_at":"2022-06-17T03:09:45.000Z","token_id":"69056e31-d5b7-4abf-8317-a189586d45d5"}', '2022-06-25 21:28:53'),
('fe6bd13b-7f2f-4ca4-a8b7-2c86a3f46e5d', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6ImZlNmJkMTNiLTdmMmYtNGNhNC1hOGI3LTJjODZhM2Y0NmU1ZCIsImlhdCI6MTY1NTc0MTAzNCwiZXhwIjoxNjU2MzQ1ODM0fQ.k2mJq-os5p71wYFq6sar2z85YJbQWDlLm0j5L3h230E', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"fe6bd13b-7f2f-4ca4-a8b7-2c86a3f46e5d"}', '2022-06-27 04:03:54'),
('73e5a07e-960e-4fa9-b440-2b7a50abf58c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6IjczZTVhMDdlLTk2MGUtNGZhOS1iNDQwLTJiN2E1MGFiZjU4YyIsImlhdCI6MTY1NTg4MTc5OCwiZXhwIjoxNjU2NDg2NTk4fQ.-yL4tBCcvY-m3BMWjSLoyHcF4CSsK9ejrC5ZfZyR0c4', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"73e5a07e-960e-4fa9-b440-2b7a50abf58c"}', '2022-06-28 19:09:58'),
('8462c350-e52c-4b61-b8f0-fa4b1e4394a6', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MTAwMDAsInRvdGFsX2xvb3QiOjAsInRvdGFsX2xvb3Rfd29uIjowLCJsb29zZV9sb29zdCI6MCwiYXZhdGFyX3VybCI6bnVsbCwidWlkIjoiNmN3YVFUWCIsImNyZWF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ1cGRhdGVkX2F0IjoiMjAyMi0wNi0yMFQwMzoyMDo1OS4wMDBaIiwidG9rZW5faWQiOiI4NDYyYzM1MC1lNTJjLTRiNjEtYjhmMC1mYTRiMWU0Mzk0YTYiLCJpYXQiOjE2NTU5ODE4ODQsImV4cCI6MTY1NjU4NjY4NH0.xQCO8nDv1cbIrKX7Nxj-ImuZ9umYuJVNZcodRcHp858', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":10000,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"8462c350-e52c-4b61-b8f0-fa4b1e4394a6"}', '2022-06-29 22:58:04'),
('bacfaae7-899f-4d4a-a5ad-f73c1b110d1a', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6ImJhY2ZhYWU3LTg5OWYtNGQ0YS1hNWFkLWY3M2MxYjExMGQxYSIsImlhdCI6MTY1NjA1NjI1OSwiZXhwIjoxNjU2NjYxMDU5fQ.FnZtE3VqSYVrp7hdVOx7hvk0kqEzY2y2FYoyoeQRuKU', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"bacfaae7-899f-4d4a-a5ad-f73c1b110d1a"}', '2022-06-30 19:37:39'),
('e35f5a30-28a9-49f3-80a1-5f7f6114b9fa', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6ImUzNWY1YTMwLTI4YTktNDlmMy04MGExLTVmN2Y2MTE0YjlmYSIsImlhdCI6MTY1NjA1NjMwNywiZXhwIjoxNjU2NjYxMTA3fQ._TSt9gAkXWQWJyDclved2-hiMtdEPfQpQfN2KJVDPFk', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"e35f5a30-28a9-49f3-80a1-5f7f6114b9fa"}', '2022-06-30 19:38:27'),
('08e62c57-e8f5-49b0-bc16-31a80ff61a8d', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6IjA4ZTYyYzU3LWU4ZjUtNDliMC1iYzE2LTMxYTgwZmY2MWE4ZCIsImlhdCI6MTY1NjA1Njg5NiwiZXhwIjoxNjU2NjYxNjk2fQ.5O6tZrwMiVec-v1OPhn6OghXWI1yir4vBAmjAhy_K3Q', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"08e62c57-e8f5-49b0-bc16-31a80ff61a8d"}', '2022-06-30 19:48:16'),
('d2bdfefc-e924-456d-bafb-ebeabb6f4ce1', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6ImQyYmRmZWZjLWU5MjQtNDU2ZC1iYWZiLWViZWFiYjZmNGNlMSIsImlhdCI6MTY1NjA1NzA3NSwiZXhwIjoxNjU2NjYxODc1fQ.ZtHoqSos2UQSuN29yRvyR2cVooE4dBjH9jCY98mhAf8', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"d2bdfefc-e924-456d-bafb-ebeabb6f4ce1"}', '2022-06-30 19:51:15'),
('deaa9523-f372-4cc2-9d22-c51e860be8dd', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6ImRlYWE5NTIzLWYzNzItNGNjMi05ZDIyLWM1MWU4NjBiZThkZCIsImlhdCI6MTY1NjA1NzEwMywiZXhwIjoxNjU2NjYxOTAzfQ.S8o1IBv4LzNpAcmEDOh1VJQAPZo9hI-1fMjX_Xr723I', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"deaa9523-f372-4cc2-9d22-c51e860be8dd"}', '2022-06-30 19:51:43'),
('bc94e457-07b5-4205-9f11-3552db6495ea', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjMiLCJmdWxsbmFtZSI6IlR1YW4gTWluaCIsIndhbGxldF9hZGRyZXNzIjoiSFBQcTF5Vng2N2JUajZzNWhZYUVKY1Y2OUEzODRmMmJMeG5IaHZmckFhc1AiLCJlbWFpbCI6ImNhdWhhaWJnQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiJIUFBxMXkiLCJjcmVhdGVkX2F0IjoiMjAyMi0wNi0yMFQwMzoyMDo1OS4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInRva2VuX2lkIjoiYmM5NGU0NTctMDdiNS00MjA1LTlmMTEtMzU1MmRiNjQ5NWVhIiwiaWF0IjoxNjU2MDYyMjY2LCJleHAiOjE2NTY2NjcwNjZ9.TzwNhyjHQLJEVUlGLmEIuyv_6Si-rIQ5rCQdC6ZrTkY', '{"id":"3","fullname":"Tuan Minh","wallet_address":"HPPq1yVx67bTj6s5hYaEJcV69A384f2bLxnHhvfrAasP","email":"cauhaibg@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"HPPq1y","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"bc94e457-07b5-4205-9f11-3552db6495ea"}', '2022-06-30 21:17:46'),
('11aab148-a802-4136-a533-58b27d48dd94', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjMiLCJmdWxsbmFtZSI6IlR1YW4gTWluaCIsIndhbGxldF9hZGRyZXNzIjoiSFBQcTF5Vng2N2JUajZzNWhZYUVKY1Y2OUEzODRmMmJMeG5IaHZmckFhc1AiLCJlbWFpbCI6ImNhdWhhaWJnQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiJIUFBxMXkiLCJjcmVhdGVkX2F0IjoiMjAyMi0wNi0yMFQwMzoyMDo1OS4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInRva2VuX2lkIjoiMTFhYWIxNDgtYTgwMi00MTM2LWE1MzMtNThiMjdkNDhkZDk0IiwiaWF0IjoxNjU2MDgzMTA1LCJleHAiOjE2NTY2ODc5MDV9.NTXdPg9p7SsJbzsNOtsz3qrAQ1PNTzBP6MLU-f0_Ghk', '{"id":"3","fullname":"Tuan Minh","wallet_address":"HPPq1yVx67bTj6s5hYaEJcV69A384f2bLxnHhvfrAasP","email":"cauhaibg@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"HPPq1y","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"11aab148-a802-4136-a533-58b27d48dd94"}', '2022-07-01 03:05:05'),
('520fb14d-2493-4e41-8a33-2f19ea7f7e3c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjExIiwiZnVsbG5hbWUiOiJEZXYwOCIsIndhbGxldF9hZGRyZXNzIjoiODRUNlM2VVBlRkJUdDgyWTlmZ1Z4Ym02WWR6OEVzSnEzeUJUejZUSzljZFMiLCJlbWFpbCI6ImRldjA4QGVvc3ZubC5jb20iLCJlbWFpbF92ZXJpZmllZF9hdCI6IjIwMjItMDYtMTdUMDM6MDk6NDUuMDAwWiIsImFjdGl2ZSI6MSwic29sX2JhbGFuY2UiOjAsInRvdGFsX2xvb3QiOjAsInRvdGFsX2xvb3Rfd29uIjowLCJsb29zZV9sb29zdCI6MCwiYXZhdGFyX3VybCI6bnVsbCwidWlkIjoiODRUNlM2IiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6IjUyMGZiMTRkLTI0OTMtNGU0MS04YTMzLTJmMTllYTdmN2UzYyIsImlhdCI6MTY1NjEyNjk5MCwiZXhwIjoxNjU2NzMxNzkwfQ.6jqVfO5_3Lz06SfaGdBYiY3bk3PBT9gON8ND9N0nGXQ', '{"id":"11","fullname":"Dev08","wallet_address":"84T6S6UPeFBTt82Y9fgVxbm6Ydz8EsJq3yBTz6TK9cdS","email":"dev08@eosvnl.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"84T6S6","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"520fb14d-2493-4e41-8a33-2f19ea7f7e3c"}', '2022-07-02 03:16:30'),
('7408f36a-7e2b-41a2-81db-fc6fe3bf98d5', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6Ijc0MDhmMzZhLTdlMmItNDFhMi04MWRiLWZjNmZlM2JmOThkNSIsImlhdCI6MTY1NjEyODUwOCwiZXhwIjoxNjU2NzMzMzA4fQ.0e1iMclMv5Ee5k7Xz5XIP8iGLW7u3Xfm6rk0mwQAJOg', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"7408f36a-7e2b-41a2-81db-fc6fe3bf98d5"}', '2022-07-02 03:41:48'),
('b9d0a8a9-479b-4fcf-a58a-e4e39111f656', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJ1c2VybmFtZSI6ImFkbWluIiwiZW1haWwiOiJ0YWkuaWN0dUBnbWFpbC5jb20iLCJhY3RpdmUiOjEsImF2YXRhcl91cmwiOiIiLCJjcmVhdGVkX2F0IjoiMjAyMi0wNy0wM1QxNzoyMDo0Ni4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjItMDctMDNUMTc6MjA6NDYuMDAwWiIsInRva2VuX2lkIjoiYjlkMGE4YTktNDc5Yi00ZmNmLWE1OGEtZTRlMzkxMTFmNjU2IiwiaWF0IjoxNjU2ODcyMTgxLCJleHAiOjE2NTc0NzY5ODF9.YeyCqc65A2ZRax4t8GG07ixYM0IsAkJZJpbTvDS5zz0', '{"id":"1","username":"admin","email":"tai.ictu@gmail.com","active":1,"avatar_url":"","created_at":"2022-07-03T17:20:46.000Z","updated_at":"2022-07-03T17:20:46.000Z","token_id":"b9d0a8a9-479b-4fcf-a58a-e4e39111f656"}', '2022-07-10 18:16:21'),
('63e27569-e0b0-442c-9828-68546842ecdf', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6IjYzZTI3NTY5LWUwYjAtNDQyYy05ODI4LTY4NTQ2ODQyZWNkZiIsImlhdCI6MTY1NjQ3NDA0OCwiZXhwIjoxNjU3MDc4ODQ4fQ.xrehXs24P5uh2elqvMgu84ZsfdsoDMS1dsPkY2b8lZE', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"63e27569-e0b0-442c-9828-68546842ecdf"}', '2022-07-06 03:40:48'),
('d87d630a-517c-4695-8d7d-ee046c83973c', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6ImQ4N2Q2MzBhLTUxN2MtNDY5NS04ZDdkLWVlMDQ2YzgzOTczYyIsImlhdCI6MTY1NjU1NTI3MCwiZXhwIjoxNjU3MTYwMDcwfQ.m2jau21mPZDRH3qNKj0txUlK-iYfZHpt4lPgA_tJ050', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"d87d630a-517c-4695-8d7d-ee046c83973c"}', '2022-07-07 02:14:30'),
('685469c6-37c4-4b91-941f-f9e1985d412f', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6IjY4NTQ2OWM2LTM3YzQtNGI5MS05NDFmLWY5ZTE5ODVkNDEyZiIsImlhdCI6MTY1NjU1NTQ4OSwiZXhwIjoxNjU3MTYwMjg5fQ.oaEuCFEzkG0xdZHT8-gno8RXV-EQpIyx1HK-biw35hw', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"685469c6-37c4-4b91-941f-f9e1985d412f"}', '2022-07-07 02:18:09'),
('ec536c65-9d38-465e-b5e0-135f3fc01c80', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJzb2xfYmFsYW5jZSI6MCwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA2LTIwVDAzOjIwOjU5LjAwMFoiLCJ0b2tlbl9pZCI6ImVjNTM2YzY1LTlkMzgtNDY1ZS1iNWUwLTEzNWYzZmMwMWM4MCIsImlhdCI6MTY1NjY5MTMwNywiZXhwIjoxNjU3Mjk2MTA3fQ.ATIp9DXkHsyRhsoNZCY9bYf0A-DYUxLuknkPG0caBL8', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"sol_balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"ec536c65-9d38-465e-b5e0-135f3fc01c80"}', '2022-07-08 04:01:47'),
('c7c02833-e710-46b9-af4e-d92c1d88323d', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJiYWxhbmNlIjowLCJ0b3RhbF9sb290IjowLCJ0b3RhbF9sb290X3dvbiI6MCwibG9vc2VfbG9vc3QiOjAsImF2YXRhcl91cmwiOm51bGwsInVpZCI6IjZjd2FRVFgiLCJjcmVhdGVkX2F0IjoiMjAyMi0wNi0yMFQwMzoyMDo1OS4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInRva2VuX2lkIjoiYzdjMDI4MzMtZTcxMC00NmI5LWFmNGUtZDkyYzFkODgzMjNkIiwiaWF0IjoxNjU2Nzc5ODI3LCJleHAiOjE2NTczODQ2Mjd9.nCpTop3bwssACIa5VkogDntkWN7KYElAJoDRTwz0vJg', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"balance":0,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-06-20T03:20:59.000Z","token_id":"c7c02833-e710-46b9-af4e-d92c1d88323d"}', '2022-07-09 04:37:07'),
('af7c9608-8ad0-4088-a372-cf8f77e3d5c9', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJiYWxhbmNlIjo1ODAuNSwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA3LTAyVDExOjAwOjAzLjAwMFoiLCJ0b2tlbl9pZCI6ImFmN2M5NjA4LThhZDAtNDA4OC1hMzcyLWNmOGY3N2UzZDVjOSIsImlhdCI6MTY1Njg2OTkyMiwiZXhwIjoxNjU3NDc0NzIyfQ.H3-iooAex5s3HOPn2ABqm99UVAh4fvU6Di0d35aP-L4', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"balance":580.5,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-07-02T11:00:03.000Z","token_id":"af7c9608-8ad0-4088-a372-cf8f77e3d5c9"}', '2022-07-11 05:38:42'),
('a1858943-177f-4a6d-a888-6c4da6ba5696', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJ1c2VybmFtZSI6ImFkbWluIiwiZW1haWwiOiJ0YWkuaWN0dUBnbWFpbC5jb20iLCJhY3RpdmUiOjEsImF2YXRhcl91cmwiOiIiLCJjcmVhdGVkX2F0IjoiMjAyMi0wNy0wM1QxNzoyMDo0Ni4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjItMDctMDNUMTc6MjA6NDYuMDAwWiIsInRva2VuX2lkIjoiYTE4NTg5NDMtMTc3Zi00YTZkLWE4ODgtNmM0ZGE2YmE1Njk2IiwiaWF0IjoxNjU2ODcxNzk4LCJleHAiOjE2NTc0NzY1OTh9.wiMu3fupa2Tb9wFFMHrVLp_FbLxQaKx2LxxO0e14s5I', '{"id":"1","username":"admin","email":"tai.ictu@gmail.com","active":1,"avatar_url":"","created_at":"2022-07-03T17:20:46.000Z","updated_at":"2022-07-03T17:20:46.000Z","token_id":"a1858943-177f-4a6d-a888-6c4da6ba5696"}', '2022-07-10 18:09:58'),
('4f5ffecb-9bb6-4828-b352-57b598f0ae36', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJ1c2VybmFtZSI6ImFkbWluIiwiZW1haWwiOiJ0YWkuaWN0dUBnbWFpbC5jb20iLCJhY3RpdmUiOjEsImF2YXRhcl91cmwiOiIiLCJjcmVhdGVkX2F0IjoiMjAyMi0wNy0wM1QxNzoyMDo0Ni4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjItMDctMDNUMTc6MjA6NDYuMDAwWiIsInRva2VuX2lkIjoiNGY1ZmZlY2ItOWJiNi00ODI4LWIzNTItNTdiNTk4ZjBhZTM2IiwiaWF0IjoxNjU2ODcyMTk1LCJleHAiOjE2NTc0NzY5OTV9.vdUqVniW7I66GNmcDbTYkmeoDxTGs0MRIVkUnlNvuy0', '{"id":"1","username":"admin","email":"tai.ictu@gmail.com","active":1,"avatar_url":"","created_at":"2022-07-03T17:20:46.000Z","updated_at":"2022-07-03T17:20:46.000Z","token_id":"4f5ffecb-9bb6-4828-b352-57b598f0ae36"}', '2022-07-10 18:16:35'),
('2858752b-55f6-43ba-b16e-34976c821c2d', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJ1c2VybmFtZSI6ImFkbWluIiwiZW1haWwiOiJ0YWkuaWN0dUBnbWFpbC5jb20iLCJhY3RpdmUiOjEsImF2YXRhcl91cmwiOiIiLCJjcmVhdGVkX2F0IjoiMjAyMi0wNy0wM1QxNzoyMDo0Ni4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjItMDctMDNUMTc6MjA6NDYuMDAwWiIsInRva2VuX2lkIjoiMjg1ODc1MmItNTVmNi00M2JhLWIxNmUtMzQ5NzZjODIxYzJkIiwiaWF0IjoxNjU2ODcyNDUzLCJleHAiOjE2NTc0NzcyNTN9.cg-Ms7p28gXCsFb1GCE8YO8qup1tZrqHlB04-FFjFf8', '{"id":"1","username":"admin","email":"tai.ictu@gmail.com","active":1,"avatar_url":"","created_at":"2022-07-03T17:20:46.000Z","updated_at":"2022-07-03T17:20:46.000Z","token_id":"2858752b-55f6-43ba-b16e-34976c821c2d"}', '2022-07-10 18:20:53'),
('e2dd534f-ee86-4767-87b9-5bc1c5a3cdbb', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJmdWxsbmFtZSI6IkJlIFRhaSIsIndhbGxldF9hZGRyZXNzIjoiNmN3YVFUWDZGcHVyVXp5YlhRWFc4S2l6WWZvQnlmYmpIS1o5ZkJ1anFrU0siLCJlbWFpbCI6InRhaS5pY3R1QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkX2F0IjoiMjAyMi0wNi0xN1QwMzowOTo0NS4wMDBaIiwiYWN0aXZlIjoxLCJiYWxhbmNlIjo1ODAuNSwidG90YWxfbG9vdCI6MCwidG90YWxfbG9vdF93b24iOjAsImxvb3NlX2xvb3N0IjowLCJhdmF0YXJfdXJsIjpudWxsLCJ1aWQiOiI2Y3dhUVRYIiwiY3JlYXRlZF9hdCI6IjIwMjItMDYtMjBUMDM6MjA6NTkuMDAwWiIsInVwZGF0ZWRfYXQiOiIyMDIyLTA3LTAyVDExOjAwOjAzLjAwMFoiLCJ0b2tlbl9pZCI6ImUyZGQ1MzRmLWVlODYtNDc2Ny04N2I5LTViYzFjNWEzY2RiYiIsImlhdCI6MTY1Njg3MzY5MSwiZXhwIjoxNjU3NDc4NDkxfQ.bwvMgSwno8M68K_b_4mUYKB1OammI3vjh4qQCAX2X34', '{"id":"1","fullname":"Be Tai","wallet_address":"6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK","email":"tai.ictu@gmail.com","email_verified_at":"2022-06-17T03:09:45.000Z","active":1,"balance":580.5,"total_loot":0,"total_loot_won":0,"loose_loost":0,"avatar_url":null,"uid":"6cwaQTX","created_at":"2022-06-20T03:20:59.000Z","updated_at":"2022-07-02T11:00:03.000Z","token_id":"e2dd534f-ee86-4767-87b9-5bc1c5a3cdbb"}', '2022-07-10 18:41:31'),
('92913e0b-88de-4385-baea-716b97308711', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjEiLCJ1c2VybmFtZSI6ImFkbWluIiwiZW1haWwiOiJ0YWkuaWN0dUBnbWFpbC5jb20iLCJhY3RpdmUiOjEsImF2YXRhcl91cmwiOiIiLCJjcmVhdGVkX2F0IjoiMjAyMi0wNy0wM1QxNzoyMDo0Ni4wMDBaIiwidXBkYXRlZF9hdCI6IjIwMjItMDctMDNUMTc6MjA6NDYuMDAwWiIsInRva2VuX2lkIjoiOTI5MTNlMGItODhkZS00Mzg1LWJhZWEtNzE2Yjk3MzA4NzExIiwiaWF0IjoxNjU2ODc0NTEwLCJleHAiOjE2NTc0NzkzMTB9.0rmeNOuWWrG-CPlDSdTarU6E85_-QOpFnkdB1zjg5K8', '{"id":"1","username":"admin","email":"tai.ictu@gmail.com","active":1,"avatar_url":"","created_at":"2022-07-03T17:20:46.000Z","updated_at":"2022-07-03T17:20:46.000Z","token_id":"92913e0b-88de-4385-baea-716b97308711"}', '2022-07-10 18:55:10');

INSERT INTO "public"."game_playing" ("id", "user_id", "game_id", "data", "won", "bonus", "note", "heroes", "finished", "winning_hero", "created_at", "updated_at") VALUES
('1', '1', '1', '{"TotalSpent":182.91,"entry_total":353,"ticket_total":8504,"ChanceOfWinning":0.07192577368416601,"ChanceNotWin":0.928074226315834,"NoRakeEV":40.95249727233514,"PostRakeEV":-81.04275234629927}', '0', '0', '', '[]', '0', '', '2022-07-01 18:10:21', '2022-07-01 18:10:21'),
('2', '1', '2', '{"TotalSpent":48.91,"entry_total":88,"ticket_total":2474,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', '[]', '0', '', '2022-07-02 03:24:53', '2022-07-02 03:24:53'),
('3', '14', '2', '{"TotalSpent":42.88,"entry_total":64,"ticket_total":1152,"ChanceOfWinning":4.266666666666667,"ChanceNotWin":-3.2666666666666666,"NoRakeEV":197.67466666666667,"PostRakeEV":185.12938666666668}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('4', '12', '2', '{"TotalSpent":38.86,"entry_total":58,"ticket_total":1044,"ChanceOfWinning":3.8666666666666667,"ChanceNotWin":-2.8666666666666667,"NoRakeEV":163.59866666666667,"PostRakeEV":152.22950666666668}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('5', '15', '2', '{"TotalSpent":35.510000000000005,"entry_total":53,"ticket_total":954,"ChanceOfWinning":3.533333333333333,"ChanceNotWin":-2.533333333333333,"NoRakeEV":137.65866666666668,"PostRakeEV":127.26960666666668}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('6', '16', '2', '{"TotalSpent":5.52,"entry_total":8,"ticket_total":144,"ChanceOfWinning":0.5333333333333333,"ChanceNotWin":0.4666666666666667,"NoRakeEV":4.6240000000000006,"PostRakeEV":3.05584}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('7', '17', '2', '{"TotalSpent":10.72,"entry_total":16,"ticket_total":288,"ChanceOfWinning":1.0666666666666667,"ChanceNotWin":-0.06666666666666665,"NoRakeEV":15.114666666666666,"PostRakeEV":11.978346666666665}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('8', '18', '2', '{"TotalSpent":33.5,"entry_total":50,"ticket_total":900,"ChanceOfWinning":3.3333333333333335,"ChanceNotWin":-2.3333333333333335,"NoRakeEV":123.16666666666667,"PostRakeEV":113.36566666666667}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('9', '11', '2', '{"TotalSpent":31.490000000000002,"entry_total":47,"ticket_total":846,"ChanceOfWinning":3.1333333333333333,"ChanceNotWin":-2.1333333333333333,"NoRakeEV":109.47866666666667,"PostRakeEV":100.26572666666667}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('10', '13', '2', '{"TotalSpent":14.74,"entry_total":22,"ticket_total":396,"ChanceOfWinning":1.4666666666666666,"ChanceNotWin":-0.46666666666666656,"NoRakeEV":26.67866666666666,"PostRakeEV":22.366226666666662}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('11', '20', '2', '{"TotalSpent":17.42,"entry_total":26,"ticket_total":468,"ChanceOfWinning":1.7333333333333334,"ChanceNotWin":-0.7333333333333334,"NoRakeEV":36.17466666666667,"PostRakeEV":31.07814666666667}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('12', '19', '2', '{"TotalSpent":41.54,"entry_total":62,"ticket_total":1116,"ChanceOfWinning":4.133333333333334,"ChanceNotWin":-3.1333333333333337,"NoRakeEV":185.9586666666667,"PostRakeEV":173.80542666666668}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('13', '21', '2', '{"TotalSpent":46.900000000000006,"entry_total":70,"ticket_total":1260,"ChanceOfWinning":4.666666666666667,"ChanceNotWin":-3.666666666666667,"NoRakeEV":234.9666666666667,"PostRakeEV":221.24526666666668}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('14', '23', '2', '{"TotalSpent":6.8999999999999995,"entry_total":10,"ticket_total":180,"ChanceOfWinning":0.6666666666666666,"ChanceNotWin":0.33333333333333337,"NoRakeEV":6.699999999999999,"PostRakeEV":4.739799999999999}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('15', '22', '2', '{"TotalSpent":45.56,"entry_total":68,"ticket_total":1224,"ChanceOfWinning":4.533333333333333,"ChanceNotWin":-3.533333333333333,"NoRakeEV":222.17866666666666,"PostRakeEV":208.84930666666668}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('16', '25', '2', '{"TotalSpent":6.8999999999999995,"entry_total":10,"ticket_total":180,"ChanceOfWinning":0.6666666666666666,"ChanceNotWin":0.33333333333333337,"NoRakeEV":6.699999999999999,"PostRakeEV":4.739799999999999}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('17', '27', '2', '{"TotalSpent":29.48,"entry_total":44,"ticket_total":792,"ChanceOfWinning":2.933333333333333,"ChanceNotWin":-1.9333333333333331,"NoRakeEV":96.59466666666665,"PostRakeEV":87.96978666666666}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('18', '24', '2', '{"TotalSpent":60.970000000000006,"entry_total":91,"ticket_total":1638,"ChanceOfWinning":6.066666666666666,"ChanceNotWin":-5.066666666666666,"NoRakeEV":390.81466666666665,"PostRakeEV":372.9768466666667}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('19', '26', '2', '{"TotalSpent":16.080000000000002,"entry_total":24,"ticket_total":432,"ChanceOfWinning":1.6,"ChanceNotWin":-0.6000000000000001,"NoRakeEV":31.248000000000005,"PostRakeEV":26.543520000000004}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('20', '28', '2', '{"TotalSpent":27.470000000000002,"entry_total":41,"ticket_total":738,"ChanceOfWinning":2.7333333333333334,"ChanceNotWin":-1.7333333333333334,"NoRakeEV":84.51466666666667,"PostRakeEV":76.47784666666666}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('21', '30', '2', '{"TotalSpent":21.44,"entry_total":32,"ticket_total":576,"ChanceOfWinning":2.1333333333333333,"ChanceNotWin":-1.1333333333333333,"NoRakeEV":53.09866666666667,"PostRakeEV":46.826026666666664}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('22', '31', '2', '{"TotalSpent":45.56,"entry_total":68,"ticket_total":1224,"ChanceOfWinning":4.533333333333333,"ChanceNotWin":-3.533333333333333,"NoRakeEV":222.17866666666666,"PostRakeEV":208.84930666666668}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('23', '29', '2', '{"TotalSpent":35.510000000000005,"entry_total":53,"ticket_total":954,"ChanceOfWinning":3.533333333333333,"ChanceNotWin":-2.533333333333333,"NoRakeEV":137.65866666666668,"PostRakeEV":127.26960666666668}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('24', '5', '2', '{"TotalSpent":154.77000000000004,"entry_total":328,"ticket_total":6610,"ChanceOfWinning":24.48148148148148,"ChanceNotWin":-23.48148148148148,"NoRakeEV":3964.7288888888897,"PostRakeEV":3892.7459888888898}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('25', '10', '2', '{"TotalSpent":79.06,"entry_total":133,"ticket_total":4311,"ChanceOfWinning":15.966666666666667,"ChanceNotWin":-14.966666666666667,"NoRakeEV":1398.8146666666667,"PostRakeEV":1351.8678766666667}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('26', '3', '2', '{"TotalSpent":214.4,"entry_total":394,"ticket_total":13867,"ChanceOfWinning":51.35925925925926,"ChanceNotWin":-50.35925925925926,"NoRakeEV":11490.375185185187,"PostRakeEV":11339.363555185186}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('27', '4', '2', '{"TotalSpent":113.22999999999999,"entry_total":208,"ticket_total":5404,"ChanceOfWinning":20.014814814814816,"ChanceNotWin":-19.014814814814816,"NoRakeEV":2423.2474814814814,"PostRakeEV":2364.3979214814817}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('28', '9', '2', '{"TotalSpent":78.39000000000001,"entry_total":187,"ticket_total":2972,"ChanceOfWinning":11.007407407407408,"ChanceNotWin":-10.007407407407408,"NoRakeEV":933.0806666666668,"PostRakeEV":900.7155866666668}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('29', '6', '2', '{"TotalSpent":231.82000000000002,"entry_total":423,"ticket_total":12260,"ChanceOfWinning":45.407407407407405,"ChanceNotWin":-44.407407407407405,"NoRakeEV":10907.525185185186,"PostRakeEV":10774.013785185187}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('30', '7', '2', '{"TotalSpent":230.48000000000002,"entry_total":395,"ticket_total":12760,"ChanceOfWinning":47.25925925925926,"ChanceNotWin":-46.25925925925926,"NoRakeEV":11299.834074074075,"PostRakeEV":11160.877674074076}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('31', '8', '2', '{"TotalSpent":281.40000000000003,"entry_total":503,"ticket_total":15428,"ChanceOfWinning":57.14074074074074,"ChanceNotWin":-56.14074074074074,"NoRakeEV":16569.404444444448,"PostRakeEV":16401.393524444447}', '0', '0', '', NULL, '0', NULL, '2022-07-02 09:30:08', '2022-07-02 09:30:08'),
('32', '17', '3', '{"TotalSpent":12.73,"entry_total":19,"ticket_total":342,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:12', '2022-07-02 17:07:12'),
('33', '11', '3', '{"TotalSpent":30.82,"entry_total":46,"ticket_total":828,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:12', '2022-07-02 17:07:12'),
('34', '15', '3', '{"TotalSpent":60.970000000000006,"entry_total":91,"ticket_total":1638,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '1', NULL, '2022-07-02 17:07:12', '2022-07-02 18:00:03'),
('35', '14', '3', '{"TotalSpent":49.580000000000005,"entry_total":74,"ticket_total":1332,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '1', NULL, '2022-07-02 17:07:12', '2022-07-02 18:00:03'),
('36', '12', '3', '{"TotalSpent":11.39,"entry_total":17,"ticket_total":306,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:12', '2022-07-02 17:07:12'),
('37', '16', '3', '{"TotalSpent":66.33,"entry_total":99,"ticket_total":1782,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:12', '2022-07-02 17:07:12'),
('38', '18', '3', '{"TotalSpent":1.8,"entry_total":2,"ticket_total":36,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:13', '2022-07-02 17:07:13'),
('39', '19', '3', '{"TotalSpent":54.940000000000005,"entry_total":82,"ticket_total":1476,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:13', '2022-07-02 17:07:13'),
('40', '21', '3', '{"TotalSpent":30.82,"entry_total":46,"ticket_total":828,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '1', NULL, '2022-07-02 17:07:13', '2022-07-02 18:00:03'),
('41', '20', '3', '{"TotalSpent":1.8,"entry_total":2,"ticket_total":36,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '1', NULL, '2022-07-02 17:07:13', '2022-07-02 18:00:03'),
('42', '13', '3', '{"TotalSpent":50.92,"entry_total":76,"ticket_total":1368,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:13', '2022-07-02 17:07:13'),
('43', '22', '3', '{"TotalSpent":50.92,"entry_total":76,"ticket_total":1368,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '1', NULL, '2022-07-02 17:07:13', '2022-07-02 18:00:03'),
('44', '23', '3', '{"TotalSpent":22.78,"entry_total":34,"ticket_total":612,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:13', '2022-07-02 17:07:13'),
('45', '26', '3', '{"TotalSpent":48.24,"entry_total":72,"ticket_total":1296,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:13', '2022-07-02 17:07:13'),
('46', '24', '3', '{"TotalSpent":39.53,"entry_total":59,"ticket_total":1062,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:13', '2022-07-02 17:07:13'),
('47', '27', '3', '{"TotalSpent":23.450000000000003,"entry_total":35,"ticket_total":630,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:13', '2022-07-02 17:07:13'),
('48', '25', '3', '{"TotalSpent":22.78,"entry_total":34,"ticket_total":612,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '1', NULL, '2022-07-02 17:07:13', '2022-07-02 18:00:03'),
('49', '28', '3', '{"TotalSpent":3.75,"entry_total":5,"ticket_total":90,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '1', NULL, '2022-07-02 17:07:13', '2022-07-02 18:00:03'),
('50', '30', '3', '{"TotalSpent":32.830000000000005,"entry_total":49,"ticket_total":882,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:13', '2022-07-02 17:07:13'),
('51', '29', '3', '{"TotalSpent":62.980000000000004,"entry_total":94,"ticket_total":1692,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:13', '2022-07-02 17:07:13'),
('52', '31', '3', '{"TotalSpent":32.160000000000004,"entry_total":48,"ticket_total":864,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:13', '2022-07-02 17:07:13'),
('53', '4', '3', '{"TotalSpent":142.04,"entry_total":294,"ticket_total":6178,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:14', '2022-07-02 17:07:14'),
('54', '3', '3', '{"TotalSpent":198.99,"entry_total":348,"ticket_total":13453,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:14', '2022-07-02 17:07:14'),
('55', '7', '3', '{"TotalSpent":253.26,"entry_total":463,"ticket_total":13372,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '1', NULL, '2022-07-02 17:07:14', '2022-07-02 18:00:03'),
('56', '8', '3', '{"TotalSpent":250.58,"entry_total":411,"ticket_total":14600,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:14', '2022-07-02 17:07:14'),
('57', '5', '3', '{"TotalSpent":121.27000000000001,"entry_total":228,"ticket_total":5710,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '1', NULL, '2022-07-02 17:07:14', '2022-07-02 18:00:03'),
('58', '10', '3', '{"TotalSpent":118.59,"entry_total":251,"ticket_total":5373,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:14', '2022-07-02 17:07:14'),
('59', '6', '3', '{"TotalSpent":216.41000000000003,"entry_total":377,"ticket_total":11846,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:14', '2022-07-02 17:07:14'),
('60', '9', '3', '{"TotalSpent":69.68,"entry_total":161,"ticket_total":2738,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '0', NULL, '2022-07-02 17:07:14', '2022-07-02 17:07:14'),
('61', '1', '3', '{"TotalSpent":179.56,"entry_total":343,"ticket_total":8414,"ChanceOfWinning":null,"ChanceNotWin":null,"NoRakeEV":null,"PostRakeEV":null}', '0', '0', '', NULL, '1', NULL, '2022-07-02 17:07:14', '2022-07-02 18:00:03');

INSERT INTO "public"."game_transactions" ("id", "type", "amount", "event", "user_id", "description", "uid", "game_playing_id", "created_at", "updated_at") VALUES
('1', 'prize', '580.5', 'prize_for_pos_1', '1', '', 'dc2cad38-f972-4e47-a02f-fbaef662b9de', '61', '2022-07-02 18:00:03', '2022-07-02 18:00:03'),
('2', 'prize', '232.20000000000002', 'prize_for_pos_4', '25', '', 'ac510680-4b4b-40d8-92d5-ccfa0d6698d5', '48', '2022-07-02 18:00:03', '2022-07-02 18:00:03'),
('3', 'prize', '95.7825', 'prize_for_pos_5', '5', '', '9f7cbe44-3e93-4089-b804-5c08897c9686', '57', '2022-07-02 18:00:03', '2022-07-02 18:00:03'),
('4', 'prize', '95.7825', 'prize_for_pos_5', '7', '', '558c346b-d220-4e84-958c-0b967f06c4da', '55', '2022-07-02 18:00:03', '2022-07-02 18:00:03'),
('5', 'prize', '95.7825', 'prize_for_pos_5', '22', '', 'd8cfbd3f-b582-46a7-9b96-191906a0ca99', '43', '2022-07-02 18:00:03', '2022-07-02 18:00:03'),
('6', 'prize', '95.7825', 'prize_for_pos_5', '28', '', 'cafe2680-c7bb-43dc-84b1-e85886854fab', '49', '2022-07-02 18:00:03', '2022-07-02 18:00:03'),
('7', 'prize', '95.7825', 'prize_for_pos_5', '21', '', '4b5514f4-848a-47a0-a31e-ce5e1902389b', '40', '2022-07-02 18:00:03', '2022-07-02 18:00:03'),
('8', 'prize', '95.7825', 'prize_for_pos_5', '20', '', '02bad406-13b7-4b0d-b7b6-327cc26e313a', '41', '2022-07-02 18:00:03', '2022-07-02 18:00:03'),
('9', 'prize', '95.7825', 'prize_for_pos_5', '15', '', '0062d6ae-80a6-4462-a59d-cd3c4dfca0b6', '34', '2022-07-02 18:00:03', '2022-07-02 18:00:03'),
('10', 'prize', '95.7825', 'prize_for_pos_5', '14', '', 'fe712412-a1ed-4731-85c5-374847887265', '35', '2022-07-02 18:00:03', '2022-07-02 18:00:03');

INSERT INTO "public"."games" ("id", "data", "result", "back_pot", "end", "note", "raked", "created_at", "updated_at", "thieves_count") VALUES
('1', '{"NoRakePrizePool":13.5,"PostRakePrizePool":10.5597,"entry_total":15,"ticket_total":270,"user_total":1,"EstUsers":15,"EstRakePerDay":2.9403000000000006}', NULL, NULL, '0', NULL, NULL, '2022-07-01 11:19:25', '2022-07-02 09:13:17', NULL),
('2', '{"NoRakePrizePool":13.5,"PostRakePrizePool":10.5597,"entry_total":15,"ticket_total":270,"user_total":1,"EstUsers":15,"EstRakePerDay":2.9403000000000006}', 'sleep', '607.3199999999998', '0', NULL, '0', '2022-07-02 02:19:25', '2022-07-02 12:55:43', '30'),
('3', '{"NoRakePrizePool":2902.5,"PostRakePrizePool":1233.37296,"entry_total":3225,"ticket_total":117693,"user_total":30,"EstUsers":58,"EstRakePerDay":343.42704000000003}', 'sleep', '580.5', '0', NULL, '0', '2022-07-02 17:02:01', '2022-07-02 18:00:02', '30'),
('4', '{}', NULL, NULL, '0', NULL, NULL, '2022-07-03 18:41:32', '2022-07-03 18:41:32', '0');

INSERT INTO "public"."hero_tier_tickets" ("id", "tier", "tickets", "tix_from_stats", "ev_class", "post_rake_ev") VALUES
('1', 'Non-NFT', '18', NULL, '-7.12673267326733', '-7.63613861386139'),
('2', 'Common', '36', '8', '6.38316831683168', '3.9380198019802'),
('3', 'Uncommon', '38', '11', '7.12112211221122', '4.54013201320132'),
('4', 'Rare', '45', '14', '4.08415841584158', '2.55594059405941'),
('5', 'Epic', '50', '16', '4.9546204620462', '3.25660066006601'),
('6', 'Legendary', '55', '17', '3.22475247524753', '2.10405940594059'),
('7', 'Mythic', '60', '18', '0.98019801980198', '0.572673267326733');

INSERT INTO "public"."heroes" ("id", "mint", "user_id", "active", "extra_data") VALUES
('1', '3yWEQJ5aKDyGp1RfYSxvGMrVyTe49niwdSidHX11M426', '1', '1', NULL),
('2', '6PF5RexLesANBdVTYagomxp5fQ8EQykY3c8dWLLeZayT', '1', '1', NULL),
('3', '94K5xjAeXWLQrGRUQhR6ZjqBfai7TRQWo52KEzp7TrnA', '1', '1', NULL),
('4', '5HE8cKE5ssaegPv11JFzjoeQecb7PhBuq3qz3W1GNGQb', '1', '1', NULL),
('5', '37Hbf7rbb5EGMsbpNvqv4nZWVr1oALEu3QwNcwGUme9o', '1', '1', NULL),
('6', 'Go5MuoUvtfBX9iat1UPAeFp2tscbfPnP3vkixVmwoPai', '3', '1', NULL),
('7', '7iZjseVHj9XHEw173pwdCYx7zRGEKymX8jXXtb1LsAXg', '3', '1', NULL),
('8', 'H1w1NMSaieGjCfNQPED9WrrSGQYb9MUG1mHhNdxntz4w', '3', '1', NULL),
('9', 'JRT5H4nqtRSKfTRGbP3s66V7HN2JMcTJD4j3MHVJ1UG', '4', '1', NULL),
('10', '3agpbs4sTE7jz5qXT7LRAh5ZKwmrDaafwdrGteFy43mY', '4', '1', NULL),
('11', 'HLCDN58Gsra4PYDiwzXz7JLmLsPsXvuvbJzX6CQTc1M2', '4', '1', NULL),
('12', '2JZhGbmkgBUvtDwcnqAvfDS1Xb2XMXtVMuGz8ukHkQ8q', '5', '1', NULL),
('13', '3fgK5G4qdw2Bm7RHaGAKbYauZXt4rkfEG8vMxzoadxNN', '5', '1', NULL),
('14', '9HC48owoYLWW3AzwPFyVsHPSsciPb1brpwjXZxUoKGNw', '5', '1', NULL),
('15', '9tSx2S2JD9fuqHVj6ZLdm2RheFk7ni9nCxFQD9d5jn2w', '5', '1', NULL),
('16', '9rZrgQgS97bzgSHpYNhwio16Rj8GobYfFChQQizoKi9L', '6', '1', NULL),
('17', '4mL6ePAZryTgQT9aWroJNirEFPN8c8dprcnASyhE2Awq', '6', '1', NULL),
('18', '6Mo7bN9s2JjzgqspacfmWSnxJYCYfvuDwf1pQCt3jCPm', '6', '1', NULL),
('19', 'AXuiJrrLBE9AnbDRzAJ3S5gBTpcNQ3qeGbuoWTUFWzAa', '7', '1', NULL),
('20', '2tbGLht4P3akFVFq8AkRpYsngxNE3JQj3gaCfsWTUFN6', '7', '1', NULL),
('21', '12LxCk6cLaBRw9GR5ZpPmnsaNdd7sRVCUKge5rJpUWaA', '7', '1', NULL),
('22', 'CGFYMVddWAiWJ2EDLJaSARGZuXwMjPc88dbERa88GcdR', '7', '1', NULL),
('23', 'CkPJt7neJqG2G3gBP9NjWnoCzCuaRHYQ52guk4iMm2AL', '8', '1', NULL),
('24', 'CbAYR5SrZE8anbguFEZ9A9dhYKKmvj4iwZvVJfJSLMGN', '8', '1', NULL),
('25', 'GB2drDedQivPu43oPNVPQKPW5Jc4acmT6Dc4yEt9c6gQ', '8', '1', NULL),
('26', 'Ac3syGHoHK1mAY1PeCYfvV2tbdkUtCppUrjxhUM9MtF1', '8', '1', NULL),
('27', '9h5acNtiZ4GGZmqESKmBtoiXoGK7wF6VKBpVwbkduvqY', '8', '1', NULL),
('28', 'H46xuR97BewCnWNNEiknXB5RPJ9SCrZdDSqJuMjuLwGL', '9', '1', NULL),
('29', 'Epew2FzhLYYta7DxwJEac1yu4qvzCBeMiky1xfZkqWzA', '9', '1', NULL),
('30', 'FJs96c19GJtHJT9K1JzhF8AmEbAhVpRU9kPyvub6LQ4g', '10', '1', NULL),
('31', '9JagCaSc5UEWHKVkZcLQgAMVsuWHHyebJzSAm9umM3Gh', '10', '1', NULL);

INSERT INTO "public"."options" ("id", "option_name", "option_value", "autoload") VALUES
('1', 'wake_percent', '66', 't'),
('2', 'sleep_percent', '33', 't'),
('3', 'raw_rake_percent', '33', 't'),
('5', 'last_update_entry_calc', '{"NoRakePrizePool":2929.5,"PostRakePrizePool":1233.37296,"entry_total":3255,"ticket_total":118233,"user_total":30,"EstUsers":58,"EstRakePerDay":343.42704000000003}', 't'),
('6', 'percent_of_user_paid', '25', 't'),
('8', 'game_locked', 'false', 't'),
('9', 'bonenosher_status', 'sleep', 't'),
('10', 'rake_prize_next_day', '8.91', 't');

INSERT INTO "public"."quantity_lookup" ("id", "type", "quantity_from", "value") VALUES
('1', 'Hero', '1', '1'),
('2', 'Crew', '2', '0.9'),
('3', 'Party', '4', '0.75'),
('4', 'Faction', '8', '0.69'),
('5', 'Clan', '15', '0.67');

INSERT INTO "public"."usermeta" ("umeta_id", "user_id", "meta_key", "meta_value") VALUES
('1', '1', 'non_nft_entries', '37'),
('2', '1', 'current_entries_calc', '{"TotalSpent":188.94,"entry_total":371,"ticket_total":8666,"ChanceOfWinning":0.07270927198436071,"ChanceNotWin":0.9272907280156393,"NoRakeEV":41.26773440056385,"PostRakeEV":-85.52466014447883}'),
('3', '3', 'non_nft_entries', '15'),
('4', '9', 'non_nft_entries', '51'),
('5', '3', 'current_entries_calc', '{"TotalSpent":222.44,"entry_total":418,"ticket_total":14083,"ChanceOfWinning":0.11815885960717193,"ChanceNotWin":0.8818411403928281,"NoRakeEV":155.62581355349164,"PostRakeEV":-50.42280084505862}'),
('6', '7', 'non_nft_entries', '55'),
('7', '8', 'non_nft_entries', '97'),
('8', '5', 'non_nft_entries', '83'),
('9', '10', 'non_nft_entries', '57'),
('10', '6', 'non_nft_entries', '81'),
('11', '4', 'non_nft_entries', '35'),
('12', '9', 'current_entries_calc', '{"TotalSpent":38.39,"entry_total":67,"ticket_total":1892,"ChanceOfWinning":0.015874214469698878,"ChanceNotWin":0.9841257855303012,"NoRakeEV":9.480122412679243,"PostRakeEV":-18.20176201834093}'),
('13', '6', 'current_entries_calc', '{"TotalSpent":226.46000000000004,"entry_total":407,"ticket_total":12116,"ChanceOfWinning":0.1016553818788962,"ChanceNotWin":0.8983446181211038,"NoRakeEV":99.20928071014461,"PostRakeEV":-78.06012297180062}'),
('14', '4', 'current_entries_calc', '{"TotalSpent":152.09,"entry_total":324,"ticket_total":6448,"ChanceOfWinning":0.05409985988404776,"ChanceNotWin":0.9459001401159522,"NoRakeEV":17.204150536551822,"PostRakeEV":-77.13664798946195}'),
('15', '5', 'current_entries_calc', '{"TotalSpent":105.19,"entry_total":180,"ticket_total":5278,"ChanceOfWinning":0.04428335305024877,"ChanceNotWin":0.9557166469497512,"NoRakeEV":31.308564608556324,"PostRakeEV":-45.91394386233398}'),
('16', '8', 'current_entries_calc', '{"TotalSpent":247.23,"entry_total":401,"ticket_total":14510,"ChanceOfWinning":0.1217414650926695,"ChanceNotWin":0.8782585349073305,"NoRakeEV":145.31683228875633,"PostRakeEV":-66.97922642905687}'),
('17', '10', 'current_entries_calc', '{"TotalSpent":74.53,"entry_total":119,"ticket_total":4185,"ChanceOfWinning":0.035112889828588685,"ChanceNotWin":0.9648871101714113,"NoRakeEV":32.62505927659896,"PostRakeEV":-28.605747459034966}'),
('18', '7', 'current_entries_calc', '{"TotalSpent":257.28000000000003,"entry_total":475,"ticket_total":13480,"ChanceOfWinning":0.11309958300821399,"ChanceNotWin":0.886900416991786,"NoRakeEV":108.53833924840802,"PostRakeEV":-88.68777181404013}'),
('19', '11', 'non_nft_entries', '6'),
('20', '11', 'current_entries_calc', '{"TotalSpent":24.790000000000003,"entry_total":37,"ticket_total":666,"ChanceOfWinning":0.005587857736162501,"ChanceNotWin":0.9944121422638375,"NoRakeEV":-8.015306954617536,"PostRakeEV":-17.759564370610892}'),
('21', '18', 'current_entries_calc', '{"TotalSpent":1.8,"entry_total":2,"ticket_total":36,"ChanceOfWinning":0.00030204636411689195,"ChanceNotWin":0.9996979536358831,"NoRakeEV":-0.9002038812957788,"PostRakeEV":-1.426920498376501}'),
('22', '14', 'current_entries_calc', '{"TotalSpent":38.86,"entry_total":58,"ticket_total":1044,"ChanceOfWinning":0.008759344559389867,"ChanceNotWin":0.9912406554406101,"NoRakeEV":-12.441291248206596,"PostRakeEV":-27.716073143547536}'),
('23', '16', 'current_entries_calc', '{"TotalSpent":63.650000000000006,"entry_total":95,"ticket_total":1710,"ChanceOfWinning":0.014347202295552367,"ChanceNotWin":0.9856527977044476,"NoRakeEV":-20.022309899569585,"PostRakeEV":-45.04134921090388}'),
('24', '13', 'current_entries_calc', '{"TotalSpent":57.620000000000005,"entry_total":86,"ticket_total":1548,"ChanceOfWinning":0.012987993657026353,"ChanceNotWin":0.9870120063429737,"NoRakeEV":-18.20377708978328,"PostRakeEV":-40.85259162425433}'),
('25', '12', 'current_entries_calc', '{"TotalSpent":2.7,"entry_total":3,"ticket_total":54,"ChanceOfWinning":0.00045306954617533793,"ChanceNotWin":0.9995469304538247,"NoRakeEV":-1.3498980593521106,"PostRakeEV":-2.1399729849731934}'),
('26', '17', 'current_entries_calc', '{"TotalSpent":53.6,"entry_total":80,"ticket_total":1440,"ChanceOfWinning":0.012081854564675677,"ChanceNotWin":0.9879181454353243,"NoRakeEV":-16.982315185380955,"PostRakeEV":-38.050979868609836}'),
('27', '15', 'current_entries_calc', '{"TotalSpent":30.150000000000002,"entry_total":45,"ticket_total":810,"ChanceOfWinning":0.006796043192630069,"ChanceNotWin":0.99320395680737,"NoRakeEV":-9.711919504643962,"PostRakeEV":-21.56304338896021}'),
('28', '21', 'current_entries_calc', '{"TotalSpent":60.970000000000006,"entry_total":91,"ticket_total":1638,"ChanceOfWinning":0.013743109567318583,"ChanceNotWin":0.9862568904326814,"NoRakeEV":-19.2160968058597,"PostRakeEV":-43.18170288303255}'),
('29', '20', 'current_entries_calc', '{"TotalSpent":7.59,"entry_total":11,"ticket_total":198,"ChanceOfWinning":0.0016612550026429056,"ChanceNotWin":0.9983387449973571,"NoRakeEV":-2.631502680661481,"PostRakeEV":-5.528444074605452}'),
('30', '19', 'current_entries_calc', '{"TotalSpent":44.89,"entry_total":67,"ticket_total":1206,"ChanceOfWinning":0.01011855319791588,"ChanceNotWin":0.9898814468020841,"NoRakeEV":-14.310821566110398,"PostRakeEV":-31.955828238314584}'),
('31', '22', 'current_entries_calc', '{"TotalSpent":13.4,"entry_total":20,"ticket_total":360,"ChanceOfWinning":0.0030204636411689193,"ChanceNotWin":0.9969795363588311,"NoRakeEV":-4.36700143472023,"PostRakeEV":-9.63416760552745}'),
('32', '24', 'current_entries_calc', '{"TotalSpent":67,"entry_total":100,"ticket_total":1800,"ChanceOfWinning":0.015102318205844597,"ChanceNotWin":0.9848976817941554,"NoRakeEV":-21.025522917767873,"PostRakeEV":-47.36135377180397}'),
('33', '23', 'current_entries_calc', '{"TotalSpent":50.92,"entry_total":76,"ticket_total":1368,"ChanceOfWinning":0.011477761836441894,"ChanceNotWin":0.9885222381635581,"NoRakeEV":-16.163959827833565,"PostRakeEV":-36.17919127690101}'),
('34', '26', 'current_entries_calc', '{"TotalSpent":18.76,"entry_total":28,"ticket_total":504,"ChanceOfWinning":0.0042286490976364876,"ChanceNotWin":0.9957713509023635,"NoRakeEV":-6.091136449444988,"PostRakeEV":-13.465169088575095}'),
('35', '25', 'current_entries_calc', '{"TotalSpent":21.44,"entry_total":32,"ticket_total":576,"ChanceOfWinning":0.004832741825870271,"ChanceNotWin":0.9951672581741298,"NoRakeEV":-6.9483470512723695,"PostRakeEV":-15.375812924563922}'),
('36', '28', 'current_entries_calc', '{"TotalSpent":6.8999999999999995,"entry_total":10,"ticket_total":180,"ChanceOfWinning":0.0015102318205844597,"ChanceNotWin":0.9984897681794156,"NoRakeEV":-2.393317224193913,"PostRakeEV":-5.026900309597523}'),
('37', '27', 'current_entries_calc', '{"TotalSpent":44.220000000000006,"entry_total":66,"ticket_total":1188,"ChanceOfWinning":0.009967530015857434,"ChanceNotWin":0.9900324699841425,"NoRakeEV":-14.103905459488033,"PostRakeEV":-31.485553823151857}'),
('38', '29', 'current_entries_calc', '{"TotalSpent":36.18,"entry_total":54,"ticket_total":972,"ChanceOfWinning":0.008155251831156082,"ChanceNotWin":0.9918447481688439,"NoRakeEV":-11.605127237030885,"PostRakeEV":-25.82647589821038}'),
('39', '30', 'current_entries_calc', '{"TotalSpent":46.230000000000004,"entry_total":69,"ticket_total":1242,"ChanceOfWinning":0.010420599562032772,"ChanceNotWin":0.9895794004379672,"NoRakeEV":-14.724046666163254,"PostRakeEV":-32.89576995544816}'),
('40', '31', 'current_entries_calc', '{"TotalSpent":14.07,"entry_total":21,"ticket_total":378,"ChanceOfWinning":0.0031714868232273655,"ChanceNotWin":0.9968285131767727,"NoRakeEV":-4.583226610284678,"PostRakeEV":-10.11375108963226}'),
('41', '14', 'non_nft_entries', '34'),
('42', '13', 'non_nft_entries', '42'),
('43', '12', 'non_nft_entries', '64'),
('44', '16', 'non_nft_entries', '81'),
('45', '18', 'non_nft_entries', '72'),
('46', '15', 'non_nft_entries', '68'),
('47', '17', 'non_nft_entries', '6'),
('48', '21', 'non_nft_entries', '35'),
('49', '20', 'non_nft_entries', '34'),
('50', '19', 'non_nft_entries', '17'),
('51', '22', 'non_nft_entries', '50'),
('52', '24', 'non_nft_entries', '68'),
('53', '23', 'non_nft_entries', '50'),
('54', '26', 'non_nft_entries', '67'),
('55', '25', 'non_nft_entries', '64'),
('56', '27', 'non_nft_entries', '53'),
('57', '28', 'non_nft_entries', '4'),
('58', '29', 'non_nft_entries', '71'),
('59', '30', 'non_nft_entries', '15'),
('60', '31', 'non_nft_entries', '61');

INSERT INTO "public"."users" ("id", "fullname", "wallet_address", "password", "email", "email_verified_at", "balance", "total_loot", "total_loot_won", "loose_loost", "active", "avatar_url", "uid", "created_at", "updated_at") VALUES
('1', 'Be Tai', '6cwaQTX6FpurUzybXQXW8KizYfoByfbjHKZ9fBujqkSK', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'tai.ictu@gmail.com', '2022-06-17 10:09:45', '580.5', '0', '0', '0', '1', NULL, '6cwaQTX', '2022-06-20 10:20:59', '2022-07-02 18:00:03'),
('3', 'Tuan Minh', 'HPPq1yVx67bTj6s5hYaEJcV69A384f2bLxnHhvfrAasP', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'cauhaibg@gmail.com', '2022-06-17 10:09:45', '0', '0', '0', '0', '1', NULL, 'HPPq1y', '2022-06-20 10:20:59', '2022-06-20 10:20:59'),
('4', 'Dev01', 'AwChzhPxxZsWZEN2AHxaAKDNjr5zCZyUZ2wSYjPaHZeF', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'dev01@eosvnl.com', '2022-06-17 10:09:45', '0', '0', '0', '0', '1', NULL, 'AwChzh', '2022-06-20 10:20:59', '2022-06-20 10:20:59'),
('5', 'Dev02', 'gA5z7qqQ3vnAvLv7tza86Mrbbwk4J8TW9YkjDdR9925S', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'dev02@eosvnl.com', '2022-06-17 10:09:45', '95.7825', '0', '0', '0', '1', NULL, 'gA5z7q', '2022-06-20 10:20:59', '2022-07-02 18:00:03'),
('6', 'Dev03', 'XLmLKRV9unTS9KEVcTL5WKTQ5te4fqJnEDvLMQ77JM2k', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'dev03@eosvnl.com', '2022-06-17 10:09:45', '0', '0', '0', '0', '1', NULL, 'XLmLKa', '2022-06-20 10:20:59', '2022-06-20 10:20:59'),
('7', 'Dev04', 'uQTGSZRe5hs4HdgpY6kE8SfcGGHPaGkFph9Ky2fqrB5p', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'dev04@eosvnl.com', '2022-06-17 10:09:45', '95.7825', '0', '0', '0', '1', NULL, 'uQTGSZ', '2022-06-20 10:20:59', '2022-07-02 18:00:03'),
('8', 'Dev05', 'SPaL5NesBfaaSJmwQZa7tXp6WPXkw33XvjjLDKnvvw9J', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'dev05@eosvnl.com', '2022-06-17 10:09:45', '0', '0', '0', '0', '1', NULL, 'SPaL5N', '2022-06-20 10:20:59', '2022-06-20 10:20:59'),
('9', 'Dev06', 'NZtYWUqEEukUvMdZTdSmGxX7xa5MfufjnFrAGNjnFnHw', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'dev06@eosvnl.com', '2022-06-17 10:09:45', '0', '0', '0', '0', '1', NULL, 'NZtYWU', '2022-06-20 10:20:59', '2022-06-20 10:20:59'),
('10', 'Dev07', 'a5vrcFmkg8z8H8DKszZ9tL2Vz3eGB6HStzy3B5kD5rgT', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'dev07@eosvnl.com', '2022-06-17 10:09:45', '0', '0', '0', '0', '1', NULL, 'a5vrcF', '2022-06-20 10:20:59', '2022-06-20 10:20:59'),
('11', 'Dev08', '84T6S6UPeFBTt82Y9fgVxbm6Ydz8EsJq3yBTz6TK9cdS', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'dev08@eosvnl.com', '2022-06-17 10:09:45', '0', '0', '0', '0', '1', NULL, '84T6S6', '2022-06-20 10:20:59', '2022-06-20 10:20:59'),
('12', 'Test 00', 'TuDILPHhemQ3jCIgwmxe949QJFbW89zfpqgkahAh0COv', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u50310@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da65f', '2022-06-30 09:01:23', '2022-06-30 09:01:23'),
('13', 'Test 01', 'iKkycEObKQDxLz9wdVL6xGtOkDgez9hhUozYq8lXwGfg', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u78891@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da660', '2022-06-30 09:01:23', '2022-06-30 09:01:23'),
('14', 'Test 02', 'zhvmSlBZ2HzqywghDguG8pvbke7pUksi6k6SBQLWy53N', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u94765@cqgame.com', NULL, '95.7825', '0', '0', '0', '1', '', '662bd6662da661', '2022-06-30 09:01:23', '2022-07-02 18:00:03'),
('15', 'Test 03', 'QO7xnJsiPFH7GZf5A2R8Q0iTq5xGLmtyGfQZi9aE2qdZ', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u21967@cqgame.com', NULL, '95.7825', '0', '0', '0', '1', '', '662bd6662da662', '2022-06-30 09:01:23', '2022-07-02 18:00:03'),
('16', 'Test 04', 'uqfSXjt5lQOuVgcjmwzVutWXYm1UsHyZtuOW3x47yDOW', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u91049@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da663', '2022-06-30 09:01:23', '2022-06-30 09:01:23'),
('17', 'Test 05', 'wK6w6XO0lZv9ZNhH9Ehp510iDBaBH36lfqCLpLIdVXOg', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u48697@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da664', '2022-06-30 09:01:23', '2022-06-30 09:01:23'),
('18', 'Test 06', 'Y4oJInHhS4Hm3tFBEA80Ha5jEUaEhXqsAY7QBHZrKnkf', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u84204@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da665', '2022-06-30 09:01:23', '2022-06-30 09:01:23'),
('19', 'Test 07', 'iDsUPAdimnOXO0FI3U0OOkE9cxncs8RT658vZQDHtfMo', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u62630@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da666', '2022-06-30 09:01:23', '2022-06-30 09:01:23'),
('20', 'Test 08', 'r33mJsKXHdv3vFGIwlka8b8TzUZArmuQ7ib1ZDQj5tCH', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u47053@cqgame.com', NULL, '95.7825', '0', '0', '0', '1', '', '662bd6662da667', '2022-06-30 09:01:23', '2022-07-02 18:00:03'),
('21', 'Test 09', 'x7rUH93tyfUTgkFeZWhT53A8IcVTguworrXEYfxipPbC', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u60872@cqgame.com', NULL, '95.7825', '0', '0', '0', '1', '', '662bd6662da668', '2022-06-30 09:01:23', '2022-07-02 18:00:03'),
('22', 'Test 010', 'aF5z6AhamTLttN2xWTQLLSj4WcHy1MJr06i5BEyi1gWr', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u24365@cqgame.com', NULL, '95.7825', '0', '0', '0', '1', '', '662bd6662da669', '2022-06-30 09:01:23', '2022-07-02 18:00:03'),
('23', 'Test 011', 'h8H2dQuhAur4DqUSbbsyVjorE8OLSvOIR2TnbInS0jwW', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u41569@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da66a', '2022-06-30 09:01:23', '2022-06-30 09:01:23'),
('24', 'Test 012', '4dnABL1ZvwLDLMrskVV6gbVBYvfLqJOs0sHo7nHI59So', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u57048@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da66b', '2022-06-30 09:01:23', '2022-06-30 09:01:23'),
('25', 'Test 013', 'WYGZSOU4ceYAbqm4qBqjPo7sMY5Cy1VqudXNvEv8B7cF', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u94060@cqgame.com', NULL, '232.20000000000002', '0', '0', '0', '1', '', '662bd6662da66c', '2022-06-30 09:01:23', '2022-07-02 18:00:03'),
('26', 'Test 014', 'o0r34G5WjCYdW8SYf7pb29UkmxGRUCwyxi0oRhUDzBC9', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u10760@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da66d', '2022-06-30 09:01:23', '2022-06-30 09:01:23'),
('27', 'Test 015', 'tb7HHZpakOSDIIEmQKnVsWBOLCfi9b8kQnDG265wXrbz', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u75901@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da66e', '2022-06-30 09:01:23', '2022-06-30 09:01:23'),
('28', 'Test 016', 'hO6WTxwjt3fG4wf82K2MnZMcQ0hUcUnh4uWnzwwJhn7D', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u52516@cqgame.com', NULL, '95.7825', '0', '0', '0', '1', '', '662bd6662da66f', '2022-06-30 09:01:23', '2022-07-02 18:00:03'),
('29', 'Test 017', '5Z2lD6kYjbxwoWqQhiViYcU5M45wN4G3PvVhljdUuVWA', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u36738@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da670', '2022-06-30 09:01:23', '2022-06-30 09:01:23'),
('30', 'Test 018', 'tRlfjNctZeESdNWiAjGHqr0SlMeL88zuM9ieyooc4yyQ', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u83712@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da671', '2022-06-30 09:01:23', '2022-06-30 09:01:23'),
('31', 'Test 019', '9awpavc3U1F6QUMdj3tZDQtzvNQQEWXzfEMcX5zFQOo1', '$2b$06$fTbMrcSj9tAZZWG3KSJh.OL1a4e1UgmRCwtxS1y4uBiGylnchpJI6', 'u74093@cqgame.com', NULL, '0', '0', '0', '0', '1', '', '662bd6662da672', '2022-06-30 09:01:23', '2022-06-30 09:01:23');

ALTER TABLE "public"."game_playing" ADD FOREIGN KEY ("game_id") REFERENCES "public"."games"("id");
ALTER TABLE "public"."game_playing" ADD FOREIGN KEY ("user_id") REFERENCES "public"."users"("id");
ALTER TABLE "public"."game_transactions" ADD FOREIGN KEY ("user_id") REFERENCES "public"."users"("id");
ALTER TABLE "public"."heroes" ADD FOREIGN KEY ("user_id") REFERENCES "public"."users"("id");
ALTER TABLE "public"."usermeta" ADD FOREIGN KEY ("user_id") REFERENCES "public"."users"("id");
