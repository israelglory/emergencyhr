BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "facility" ADD COLUMN "sourceRef" text;
CREATE UNIQUE INDEX "facility_source_ref_idx" ON "facility" USING btree ("sourceRef");

--
-- MIGRATION VERSION FOR emergencyhr
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('emergencyhr', '20261007161825493-hospital-import', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261007161825493-hospital-import', "timestamp" = now();

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
