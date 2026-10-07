BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "app_user" ADD COLUMN "email" text;
ALTER TABLE "app_user" ALTER COLUMN "phone" DROP NOT NULL;
CREATE UNIQUE INDEX "app_user_email_idx" ON "app_user" USING btree ("email");
--
-- ACTION ALTER TABLE
--
ALTER TABLE "facility_invite" DROP COLUMN "phone";
ALTER TABLE "facility_invite" ADD COLUMN "email" text;

--
-- MIGRATION VERSION FOR emergencyhr
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('emergencyhr', '20261006213927706-email-sign-in', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006213927706-email-sign-in', "timestamp" = now();

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
