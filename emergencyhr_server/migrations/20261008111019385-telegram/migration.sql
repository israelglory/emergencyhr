BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "telegram_link" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "telegramUserId" bigint NOT NULL,
    "chatId" bigint NOT NULL,
    "linkedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "telegram_link_user_idx" ON "telegram_link" USING btree ("userId");
CREATE UNIQUE INDEX "telegram_link_telegram_user_idx" ON "telegram_link" USING btree ("telegramUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "telegram_link_code" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "codeHash" text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "usedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "telegram_link_code_hash_idx" ON "telegram_link_code" USING btree ("codeHash");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "telegram_link"
    ADD CONSTRAINT "telegram_link_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "telegram_link_code"
    ADD CONSTRAINT "telegram_link_code_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR emergencyhr
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('emergencyhr', '20261008111019385-telegram', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261008111019385-telegram', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260924105404509', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105404509', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260924105232991', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260924105232991', "timestamp" = now();


COMMIT;
