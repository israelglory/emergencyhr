BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "admin_action_log" (
    "id" bigserial PRIMARY KEY,
    "actorUserId" bigint NOT NULL,
    "action" text NOT NULL,
    "targetType" text NOT NULL,
    "targetId" bigint NOT NULL,
    "reason" text,
    "at" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "admin_action_log_target_idx" ON "admin_action_log" USING btree ("targetType", "targetId", "at");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ai_conversation" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "ai_conversation_user_idx" ON "ai_conversation" USING btree ("userId", "updatedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "ai_message" (
    "id" bigserial PRIMARY KEY,
    "conversationId" bigint NOT NULL,
    "role" text NOT NULL,
    "contentEnc" text,
    "redFlagDetected" boolean NOT NULL DEFAULT false,
    "suggestedEmergencyType" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "ai_message_conversation_idx" ON "ai_message" USING btree ("conversationId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "app_user" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "phone" text NOT NULL,
    "name" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "suspendedAt" timestamp without time zone,
    "suspendReason" text
);

-- Indexes
CREATE UNIQUE INDEX "app_user_phone_idx" ON "app_user" USING btree ("phone");
CREATE UNIQUE INDEX "app_user_auth_user_idx" ON "app_user" USING btree ("authUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "claim_request" (
    "id" bigserial PRIMARY KEY,
    "facilityId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "contactName" text NOT NULL,
    "documents" json NOT NULL,
    "deskPhoneVerified" boolean NOT NULL DEFAULT false,
    "status" text NOT NULL,
    "reviewedByUserId" bigint,
    "reason" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "reviewedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "claim_request_status_idx" ON "claim_request" USING btree ("status", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "consultation" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "doctorId" bigint NOT NULL,
    "status" text NOT NULL,
    "feeNgn" bigint NOT NULL,
    "startedAt" timestamp without time zone,
    "endedAt" timestamp without time zone,
    "note" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "doctor_availability" (
    "id" bigserial PRIMARY KEY,
    "doctorId" bigint NOT NULL,
    "weekday" bigint NOT NULL,
    "startMinute" bigint NOT NULL,
    "endMinute" bigint NOT NULL,
    "onlineNow" boolean NOT NULL DEFAULT false
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "doctor_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "mdcnNumber" text NOT NULL,
    "licenceExpiry" timestamp without time zone NOT NULL,
    "specialty" text NOT NULL,
    "feeNgn" bigint NOT NULL,
    "sessionMinutes" bigint NOT NULL,
    "facilityId" bigint,
    "verificationStatus" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "doctor_profile_user_idx" ON "doctor_profile" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "emergency_contact" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "name" text NOT NULL,
    "phone" text NOT NULL,
    "channel" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "emergency_contact_user_idx" ON "emergency_contact" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "emergency_session" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint,
    "accessTokenHash" text,
    "lat" double precision NOT NULL,
    "lng" double precision NOT NULL,
    "area" text,
    "emergencyType" text NOT NULL,
    "resultsShown" json NOT NULL,
    "emptyResult" boolean NOT NULL DEFAULT false,
    "action" text NOT NULL,
    "facilityId" bigint,
    "startedAt" timestamp without time zone NOT NULL,
    "actedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "emergency_session_started_idx" ON "emergency_session" USING btree ("startedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "facility" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "type" text NOT NULL,
    "address" text NOT NULL,
    "area" text NOT NULL,
    "lat" double precision NOT NULL,
    "lng" double precision NOT NULL,
    "deskPhone" text,
    "deskPhoneConfirmedAt" timestamp without time zone,
    "contactName" text,
    "contactPhone" text,
    "verificationStatus" text NOT NULL,
    "onboardingStage" text NOT NULL,
    "source" text NOT NULL,
    "liveAt" timestamp without time zone,
    "openingHours" json,
    "trainingCompletedAt" timestamp without time zone,
    "flaggedAt" timestamp without time zone,
    "suspendedAt" timestamp without time zone,
    "suspendReason" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "facility_location_idx" ON "facility" USING btree ("lat", "lng");
CREATE INDEX "facility_name_idx" ON "facility" USING btree ("name");
CREATE INDEX "facility_area_idx" ON "facility" USING btree ("area");
CREATE INDEX "facility_stage_idx" ON "facility" USING btree ("onboardingStage");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "facility_capability" (
    "id" bigserial PRIMARY KEY,
    "facilityId" bigint NOT NULL,
    "capability" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "facility_capability_unique_idx" ON "facility_capability" USING btree ("facilityId", "capability");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "facility_document" (
    "id" bigserial PRIMARY KEY,
    "facilityId" bigint,
    "claimRequestId" bigint,
    "kind" text NOT NULL,
    "storagePath" text NOT NULL,
    "fileName" text NOT NULL,
    "uploadedByUserId" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "facility_document_facility_idx" ON "facility_document" USING btree ("facilityId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "facility_invite" (
    "id" bigserial PRIMARY KEY,
    "facilityId" bigint NOT NULL,
    "role" text NOT NULL,
    "phone" text,
    "tokenHash" text,
    "shortCode" text NOT NULL,
    "createdByUserId" bigint NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "usedAt" timestamp without time zone,
    "usedByUserId" bigint,
    "revokedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "facility_invite_token_idx" ON "facility_invite" USING btree ("tokenHash");
CREATE UNIQUE INDEX "facility_invite_code_idx" ON "facility_invite" USING btree ("shortCode");
CREATE INDEX "facility_invite_facility_idx" ON "facility_invite" USING btree ("facilityId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "facility_status" (
    "id" bigserial PRIMARY KEY,
    "facilityId" bigint NOT NULL,
    "accepting" boolean NOT NULL,
    "erBedsFree" bigint NOT NULL,
    "icuBedsFree" bigint NOT NULL,
    "doctorOnDuty" boolean NOT NULL,
    "depositRequired" boolean NOT NULL,
    "updatedByUserId" bigint,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "facility_status_facility_idx" ON "facility_status" USING btree ("facilityId");
CREATE INDEX "facility_status_updated_idx" ON "facility_status" USING btree ("updatedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "field_agent_area" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "area" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "field_agent_area_unique_idx" ON "field_agent_area" USING btree ("userId", "area");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "join_request" (
    "id" bigserial PRIMARY KEY,
    "hospitalName" text NOT NULL,
    "contactName" text NOT NULL,
    "phone" text NOT NULL,
    "area" text NOT NULL,
    "message" text,
    "status" text NOT NULL,
    "facilityId" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "join_request_status_idx" ON "join_request" USING btree ("status", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "medical_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "bloodGroupEnc" text,
    "allergiesEnc" text,
    "conditionsEnc" text,
    "medicationsEnc" text,
    "consentAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "medical_profile_user_idx" ON "medical_profile" USING btree ("userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "notification_log" (
    "id" bigserial PRIMARY KEY,
    "facilityId" bigint,
    "toPhone" text NOT NULL,
    "kind" text NOT NULL,
    "channel" text NOT NULL,
    "success" boolean NOT NULL,
    "sentAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "notification_log_facility_idx" ON "notification_log" USING btree ("facilityId", "kind", "sentAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "onboarding_event" (
    "id" bigserial PRIMARY KEY,
    "facilityId" bigint NOT NULL,
    "fromStage" text,
    "toStage" text NOT NULL,
    "byUserId" bigint,
    "note" text,
    "at" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "onboarding_event_facility_idx" ON "onboarding_event" USING btree ("facilityId", "at");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "onboarding_record" (
    "id" bigserial PRIMARY KEY,
    "facilityId" bigint NOT NULL,
    "stage" text NOT NULL,
    "assignedAgentUserId" bigint,
    "notes" text,
    "nextActionAt" timestamp without time zone,
    "submittedAt" timestamp without time zone,
    "submittedByUserId" bigint,
    "updatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE UNIQUE INDEX "onboarding_record_facility_idx" ON "onboarding_record" USING btree ("facilityId");
CREATE INDEX "onboarding_record_agent_idx" ON "onboarding_record" USING btree ("assignedAgentUserId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "otp_challenge" (
    "id" bigserial PRIMARY KEY,
    "phone" text NOT NULL,
    "purpose" text NOT NULL,
    "codeHash" text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "attempts" bigint NOT NULL DEFAULT 0,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "consumedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "otp_challenge_phone_idx" ON "otp_challenge" USING btree ("phone", "purpose", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "payment" (
    "id" bigserial PRIMARY KEY,
    "consultationId" bigint NOT NULL,
    "amountNgn" bigint NOT NULL,
    "providerRef" text NOT NULL,
    "status" text NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "payout" (
    "id" bigserial PRIMARY KEY,
    "doctorId" bigint NOT NULL,
    "amountNgn" bigint NOT NULL,
    "commissionNgn" bigint NOT NULL,
    "status" text NOT NULL,
    "providerRef" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "role_assignment" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "role" text NOT NULL,
    "facilityId" bigint,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdByUserId" bigint
);

-- Indexes
CREATE INDEX "role_assignment_user_facility_idx" ON "role_assignment" USING btree ("userId", "facilityId");
CREATE UNIQUE INDEX "role_assignment_unique_idx" ON "role_assignment" USING btree ("userId", "role", "facilityId") NULLS NOT DISTINCT;
CREATE INDEX "role_assignment_facility_idx" ON "role_assignment" USING btree ("facilityId", "role");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "status_change_log" (
    "id" bigserial PRIMARY KEY,
    "facilityId" bigint NOT NULL,
    "userId" bigint,
    "oldValue" text,
    "newValue" text NOT NULL,
    "practice" boolean NOT NULL DEFAULT false,
    "at" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "status_change_log_facility_idx" ON "status_change_log" USING btree ("facilityId", "at");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "status_report" (
    "id" bigserial PRIMARY KEY,
    "sessionId" bigint NOT NULL,
    "facilityId" bigint NOT NULL,
    "userId" bigint,
    "reason" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "reviewedAt" timestamp without time zone,
    "reviewedByUserId" bigint
);

-- Indexes
CREATE INDEX "status_report_facility_idx" ON "status_report" USING btree ("facilityId", "createdAt");
CREATE INDEX "status_report_session_idx" ON "status_report" USING btree ("sessionId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "ai_conversation"
    ADD CONSTRAINT "ai_conversation_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "ai_message"
    ADD CONSTRAINT "ai_message_fk_0"
    FOREIGN KEY("conversationId")
    REFERENCES "ai_conversation"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "app_user"
    ADD CONSTRAINT "app_user_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "claim_request"
    ADD CONSTRAINT "claim_request_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "claim_request"
    ADD CONSTRAINT "claim_request_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "consultation"
    ADD CONSTRAINT "consultation_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "consultation"
    ADD CONSTRAINT "consultation_fk_1"
    FOREIGN KEY("doctorId")
    REFERENCES "doctor_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "doctor_availability"
    ADD CONSTRAINT "doctor_availability_fk_0"
    FOREIGN KEY("doctorId")
    REFERENCES "doctor_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "doctor_profile"
    ADD CONSTRAINT "doctor_profile_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "doctor_profile"
    ADD CONSTRAINT "doctor_profile_fk_1"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "emergency_contact"
    ADD CONSTRAINT "emergency_contact_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "emergency_session"
    ADD CONSTRAINT "emergency_session_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "emergency_session"
    ADD CONSTRAINT "emergency_session_fk_1"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "facility_capability"
    ADD CONSTRAINT "facility_capability_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "facility_document"
    ADD CONSTRAINT "facility_document_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "facility_invite"
    ADD CONSTRAINT "facility_invite_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "facility_status"
    ADD CONSTRAINT "facility_status_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "field_agent_area"
    ADD CONSTRAINT "field_agent_area_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "join_request"
    ADD CONSTRAINT "join_request_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "medical_profile"
    ADD CONSTRAINT "medical_profile_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "onboarding_event"
    ADD CONSTRAINT "onboarding_event_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "onboarding_record"
    ADD CONSTRAINT "onboarding_record_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "payment"
    ADD CONSTRAINT "payment_fk_0"
    FOREIGN KEY("consultationId")
    REFERENCES "consultation"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "payout"
    ADD CONSTRAINT "payout_fk_0"
    FOREIGN KEY("doctorId")
    REFERENCES "doctor_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "role_assignment"
    ADD CONSTRAINT "role_assignment_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "role_assignment"
    ADD CONSTRAINT "role_assignment_fk_1"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "status_change_log"
    ADD CONSTRAINT "status_change_log_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "status_report"
    ADD CONSTRAINT "status_report_fk_0"
    FOREIGN KEY("sessionId")
    REFERENCES "emergency_session"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "status_report"
    ADD CONSTRAINT "status_report_fk_1"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR emergencyhr
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('emergencyhr', '20261006013816210-foundation', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20261006013816210-foundation', "timestamp" = now();

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
