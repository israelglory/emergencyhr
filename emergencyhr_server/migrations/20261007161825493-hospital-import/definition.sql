BEGIN;

--
-- Function: gen_random_uuid_v7()
-- Source: https://gist.github.com/kjmph/5bd772b2c2df145aa645b837da7eca74
-- License: MIT (copyright notice included on the generator source code).
--
create or replace function gen_random_uuid_v7()
returns uuid
as $$
begin
  -- use random v4 uuid as starting point (which has the same variant we need)
  -- then overlay timestamp
  -- then set version 7 by flipping the 2 and 1 bit in the version 4 string
  return encode(
    set_bit(
      set_bit(
        overlay(uuid_send(gen_random_uuid())
                placing substring(int8send(floor(extract(epoch from clock_timestamp()) * 1000)::bigint) from 3)
                from 1 for 6
        ),
        52, 1
      ),
      53, 1
    ),
    'hex')::uuid;
end
$$
language plpgsql
volatile;

--
-- Class AdminActionLog as table admin_action_log
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
-- Class AiConversation as table ai_conversation
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
-- Class AiMessage as table ai_message
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
-- Class AppUser as table app_user
--
CREATE TABLE "app_user" (
    "id" bigserial PRIMARY KEY,
    "authUserId" uuid NOT NULL,
    "email" text,
    "phone" text,
    "name" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "suspendedAt" timestamp without time zone,
    "suspendReason" text
);

-- Indexes
CREATE UNIQUE INDEX "app_user_email_idx" ON "app_user" USING btree ("email");
CREATE UNIQUE INDEX "app_user_phone_idx" ON "app_user" USING btree ("phone");
CREATE UNIQUE INDEX "app_user_auth_user_idx" ON "app_user" USING btree ("authUserId");

--
-- Class ClaimRequest as table claim_request
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
-- Class Consultation as table consultation
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
-- Class DoctorAvailability as table doctor_availability
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
-- Class DoctorProfile as table doctor_profile
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
-- Class EmergencyContact as table emergency_contact
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
-- Class EmergencySession as table emergency_session
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
-- Class Facility as table facility
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
    "sourceRef" text,
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
CREATE UNIQUE INDEX "facility_source_ref_idx" ON "facility" USING btree ("sourceRef");

--
-- Class FacilityCapability as table facility_capability
--
CREATE TABLE "facility_capability" (
    "id" bigserial PRIMARY KEY,
    "facilityId" bigint NOT NULL,
    "capability" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "facility_capability_unique_idx" ON "facility_capability" USING btree ("facilityId", "capability");

--
-- Class FacilityDocument as table facility_document
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
-- Class FacilityInvite as table facility_invite
--
CREATE TABLE "facility_invite" (
    "id" bigserial PRIMARY KEY,
    "facilityId" bigint NOT NULL,
    "role" text NOT NULL,
    "email" text,
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
-- Class FacilityStatus as table facility_status
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
-- Class FieldAgentArea as table field_agent_area
--
CREATE TABLE "field_agent_area" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "area" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "field_agent_area_unique_idx" ON "field_agent_area" USING btree ("userId", "area");

--
-- Class JoinRequest as table join_request
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
-- Class MedicalProfile as table medical_profile
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
-- Class NotificationLog as table notification_log
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
-- Class OnboardingEvent as table onboarding_event
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
-- Class OnboardingRecord as table onboarding_record
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
-- Class OtpChallenge as table otp_challenge
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
-- Class Payment as table payment
--
CREATE TABLE "payment" (
    "id" bigserial PRIMARY KEY,
    "consultationId" bigint NOT NULL,
    "amountNgn" bigint NOT NULL,
    "providerRef" text NOT NULL,
    "status" text NOT NULL
);

--
-- Class Payout as table payout
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
-- Class RoleAssignment as table role_assignment
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
-- Class StatusChangeLog as table status_change_log
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
-- Class StatusReport as table status_report
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
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL,
    "contentType" text,
    "cacheControl" text,
    "contentDisposition" text,
    "contentEncoding" text,
    "customMetadata" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectDownloadEntry as table serverpod_cloud_storage_direct_download
--
CREATE TABLE "serverpod_cloud_storage_direct_download" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "downloadFileName" text,
    "contentType" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_download_auth_key" ON "serverpod_cloud_storage_direct_download" USING btree ("authKey");
CREATE INDEX "serverpod_cloud_storage_direct_download_expiration" ON "serverpod_cloud_storage_direct_download" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL,
    "maxFileSize" bigint NOT NULL DEFAULT 10485760,
    "contentLength" bigint,
    "preventOverwrite" boolean NOT NULL DEFAULT false,
    "contentType" text,
    "cacheControl" text,
    "contentDisposition" text,
    "contentEncoding" text,
    "customMetadata" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text,
    "scheduling" json
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class FutureCallClaimEntry as table serverpod_future_call_claim
--
CREATE TABLE "serverpod_future_call_claim" (
    "id" bigserial PRIMARY KEY,
    "futureCallId" bigint,
    "lastHeartbeatTime" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "future_call_unique_idx" ON "serverpod_future_call_claim" USING btree ("futureCallId");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId", "order");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_message_log_sessionLogId_idx" ON "serverpod_message_log" USING btree ("sessionLogId", "order");

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId", "order");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "userId" text,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_time_idx" ON "serverpod_session_log" USING btree ("time");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AnonymousAccount as table serverpod_auth_idp_anonymous_account
--
CREATE TABLE "serverpod_auth_idp_anonymous_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class AppleAccount as table serverpod_auth_idp_apple_account
--
CREATE TABLE "serverpod_auth_idp_apple_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userIdentifier" text NOT NULL,
    "refreshToken" text NOT NULL,
    "refreshTokenRequestedWithBundleIdentifier" boolean NOT NULL,
    "lastRefreshedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text,
    "isEmailVerified" boolean,
    "isPrivateEmail" boolean,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_apple_account_identifier" ON "serverpod_auth_idp_apple_account" USING btree ("userIdentifier");

--
-- Class EmailAccount as table serverpod_auth_idp_email_account
--
CREATE TABLE "serverpod_auth_idp_email_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_email" ON "serverpod_auth_idp_email_account" USING btree ("email");

--
-- Class EmailAccountPasswordResetRequest as table serverpod_auth_idp_email_account_password_reset_request
--
CREATE TABLE "serverpod_auth_idp_email_account_password_reset_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "emailAccountId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "challengeId" uuid NOT NULL,
    "setPasswordChallengeId" uuid
);

--
-- Class EmailAccountRequest as table serverpod_auth_idp_email_account_request
--
CREATE TABLE "serverpod_auth_idp_email_account_request" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "email" text NOT NULL,
    "challengeId" uuid NOT NULL,
    "createAccountChallengeId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_email_account_request_email" ON "serverpod_auth_idp_email_account_request" USING btree ("email");

--
-- Class FacebookAccount as table serverpod_auth_idp_facebook_account
--
CREATE TABLE "serverpod_auth_idp_facebook_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "fullName" text,
    "firstName" text,
    "lastName" text
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_facebook_account_user_identifier" ON "serverpod_auth_idp_facebook_account" USING btree ("userIdentifier");

--
-- Class FirebaseAccount as table serverpod_auth_idp_firebase_account
--
CREATE TABLE "serverpod_auth_idp_firebase_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text,
    "phone" text,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_firebase_account_user_identifier" ON "serverpod_auth_idp_firebase_account" USING btree ("userIdentifier");

--
-- Class GitHubAccount as table serverpod_auth_idp_github_account
--
CREATE TABLE "serverpod_auth_idp_github_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_github_account_user_identifier" ON "serverpod_auth_idp_github_account" USING btree ("userIdentifier");

--
-- Class GoogleAccount as table serverpod_auth_idp_google_account
--
CREATE TABLE "serverpod_auth_idp_google_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "created" timestamp without time zone NOT NULL,
    "email" text NOT NULL,
    "userIdentifier" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_google_account_user_identifier" ON "serverpod_auth_idp_google_account" USING btree ("userIdentifier");

--
-- Class MicrosoftAccount as table serverpod_auth_idp_microsoft_account
--
CREATE TABLE "serverpod_auth_idp_microsoft_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userIdentifier" text NOT NULL,
    "email" text,
    "created" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_microsoft_account_user_identifier" ON "serverpod_auth_idp_microsoft_account" USING btree ("userIdentifier");

--
-- Class PasskeyAccount as table serverpod_auth_idp_passkey_account
--
CREATE TABLE "serverpod_auth_idp_passkey_account" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "keyId" bytea NOT NULL,
    "keyIdBase64" text NOT NULL,
    "clientDataJSON" bytea NOT NULL,
    "attestationObject" bytea NOT NULL,
    "originalChallenge" bytea NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_idp_passkey_account_key_id_base64" ON "serverpod_auth_idp_passkey_account" USING btree ("keyIdBase64");

--
-- Class PasskeyChallenge as table serverpod_auth_idp_passkey_challenge
--
CREATE TABLE "serverpod_auth_idp_passkey_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "challenge" bytea NOT NULL
);

--
-- Class RateLimitedRequestAttempt as table serverpod_auth_idp_rate_limited_request_attempt
--
CREATE TABLE "serverpod_auth_idp_rate_limited_request_attempt" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "domain" text NOT NULL,
    "source" text NOT NULL,
    "key" text NOT NULL,
    "ipAddress" text,
    "attemptedAt" timestamp without time zone NOT NULL,
    "extraData" json
);

-- Indexes
CREATE INDEX "serverpod_auth_idp_rate_limited_request_attempt_composite" ON "serverpod_auth_idp_rate_limited_request_attempt" USING btree ("domain", "source", "key", "attemptedAt");

--
-- Class SecretChallenge as table serverpod_auth_idp_secret_challenge
--
CREATE TABLE "serverpod_auth_idp_secret_challenge" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "challengeCodeHash" text NOT NULL
);

--
-- Class RefreshToken as table serverpod_auth_core_jwt_refresh_token
--
CREATE TABLE "serverpod_auth_core_jwt_refresh_token" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "extraClaims" text,
    "method" text NOT NULL,
    "fixedSecret" bytea NOT NULL,
    "rotatingSecretHash" text NOT NULL,
    "lastUpdatedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Indexes
CREATE INDEX "serverpod_auth_core_jwt_refresh_token_last_updated_at" ON "serverpod_auth_core_jwt_refresh_token" USING btree ("lastUpdatedAt");

--
-- Class UserProfile as table serverpod_auth_core_profile
--
CREATE TABLE "serverpod_auth_core_profile" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "imageId" uuid
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_auth_profile_user_profile_email_auth_user_id" ON "serverpod_auth_core_profile" USING btree ("authUserId");

--
-- Class UserProfileImage as table serverpod_auth_core_profile_image
--
CREATE TABLE "serverpod_auth_core_profile_image" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "userProfileId" uuid NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "url" text NOT NULL
);

--
-- Class ServerSideSession as table serverpod_auth_core_session
--
CREATE TABLE "serverpod_auth_core_session" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "authUserId" uuid NOT NULL,
    "scopeNames" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUsedAt" timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" timestamp without time zone,
    "expireAfterUnusedFor" bigint,
    "sessionKeyHash" bytea NOT NULL,
    "sessionKeySalt" bytea NOT NULL,
    "method" text NOT NULL
);

--
-- Class AuthUser as table serverpod_auth_core_user
--
CREATE TABLE "serverpod_auth_core_user" (
    "id" uuid PRIMARY KEY DEFAULT gen_random_uuid_v7(),
    "createdAt" timestamp without time zone NOT NULL,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

--
-- Foreign relations for "ai_conversation" table
--
ALTER TABLE ONLY "ai_conversation"
    ADD CONSTRAINT "ai_conversation_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "ai_message" table
--
ALTER TABLE ONLY "ai_message"
    ADD CONSTRAINT "ai_message_fk_0"
    FOREIGN KEY("conversationId")
    REFERENCES "ai_conversation"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "app_user" table
--
ALTER TABLE ONLY "app_user"
    ADD CONSTRAINT "app_user_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "claim_request" table
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
-- Foreign relations for "consultation" table
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
-- Foreign relations for "doctor_availability" table
--
ALTER TABLE ONLY "doctor_availability"
    ADD CONSTRAINT "doctor_availability_fk_0"
    FOREIGN KEY("doctorId")
    REFERENCES "doctor_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "doctor_profile" table
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
-- Foreign relations for "emergency_contact" table
--
ALTER TABLE ONLY "emergency_contact"
    ADD CONSTRAINT "emergency_contact_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "emergency_session" table
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
-- Foreign relations for "facility_capability" table
--
ALTER TABLE ONLY "facility_capability"
    ADD CONSTRAINT "facility_capability_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "facility_document" table
--
ALTER TABLE ONLY "facility_document"
    ADD CONSTRAINT "facility_document_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "facility_invite" table
--
ALTER TABLE ONLY "facility_invite"
    ADD CONSTRAINT "facility_invite_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "facility_status" table
--
ALTER TABLE ONLY "facility_status"
    ADD CONSTRAINT "facility_status_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "field_agent_area" table
--
ALTER TABLE ONLY "field_agent_area"
    ADD CONSTRAINT "field_agent_area_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "join_request" table
--
ALTER TABLE ONLY "join_request"
    ADD CONSTRAINT "join_request_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE SET NULL
    ON UPDATE NO ACTION;

--
-- Foreign relations for "medical_profile" table
--
ALTER TABLE ONLY "medical_profile"
    ADD CONSTRAINT "medical_profile_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "app_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "onboarding_event" table
--
ALTER TABLE ONLY "onboarding_event"
    ADD CONSTRAINT "onboarding_event_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "onboarding_record" table
--
ALTER TABLE ONLY "onboarding_record"
    ADD CONSTRAINT "onboarding_record_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "payment" table
--
ALTER TABLE ONLY "payment"
    ADD CONSTRAINT "payment_fk_0"
    FOREIGN KEY("consultationId")
    REFERENCES "consultation"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "payout" table
--
ALTER TABLE ONLY "payout"
    ADD CONSTRAINT "payout_fk_0"
    FOREIGN KEY("doctorId")
    REFERENCES "doctor_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "role_assignment" table
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
-- Foreign relations for "status_change_log" table
--
ALTER TABLE ONLY "status_change_log"
    ADD CONSTRAINT "status_change_log_fk_0"
    FOREIGN KEY("facilityId")
    REFERENCES "facility"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "status_report" table
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
-- Foreign relations for "serverpod_future_call_claim" table
--
ALTER TABLE ONLY "serverpod_future_call_claim"
    ADD CONSTRAINT "serverpod_future_call_claim_fk_0"
    FOREIGN KEY("futureCallId")
    REFERENCES "serverpod_future_call"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_anonymous_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_anonymous_account"
    ADD CONSTRAINT "serverpod_auth_idp_anonymous_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_apple_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_apple_account"
    ADD CONSTRAINT "serverpod_auth_idp_apple_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_password_reset_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_0"
    FOREIGN KEY("emailAccountId")
    REFERENCES "serverpod_auth_idp_email_account"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_1"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_password_reset_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_password_reset_request_fk_2"
    FOREIGN KEY("setPasswordChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_email_account_request" table
--
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_0"
    FOREIGN KEY("challengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_idp_email_account_request"
    ADD CONSTRAINT "serverpod_auth_idp_email_account_request_fk_1"
    FOREIGN KEY("createAccountChallengeId")
    REFERENCES "serverpod_auth_idp_secret_challenge"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_facebook_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_facebook_account"
    ADD CONSTRAINT "serverpod_auth_idp_facebook_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_firebase_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_firebase_account"
    ADD CONSTRAINT "serverpod_auth_idp_firebase_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_github_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_github_account"
    ADD CONSTRAINT "serverpod_auth_idp_github_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_google_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_google_account"
    ADD CONSTRAINT "serverpod_auth_idp_google_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_microsoft_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_microsoft_account"
    ADD CONSTRAINT "serverpod_auth_idp_microsoft_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_idp_passkey_account" table
--
ALTER TABLE ONLY "serverpod_auth_idp_passkey_account"
    ADD CONSTRAINT "serverpod_auth_idp_passkey_account_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_jwt_refresh_token" table
--
ALTER TABLE ONLY "serverpod_auth_core_jwt_refresh_token"
    ADD CONSTRAINT "serverpod_auth_core_jwt_refresh_token_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_profile" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "serverpod_auth_core_profile"
    ADD CONSTRAINT "serverpod_auth_core_profile_fk_1"
    FOREIGN KEY("imageId")
    REFERENCES "serverpod_auth_core_profile_image"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
    DEFERRABLE INITIALLY DEFERRED;

--
-- Foreign relations for "serverpod_auth_core_profile_image" table
--
ALTER TABLE ONLY "serverpod_auth_core_profile_image"
    ADD CONSTRAINT "serverpod_auth_core_profile_image_fk_0"
    FOREIGN KEY("userProfileId")
    REFERENCES "serverpod_auth_core_profile"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_auth_core_session" table
--
ALTER TABLE ONLY "serverpod_auth_core_session"
    ADD CONSTRAINT "serverpod_auth_core_session_fk_0"
    FOREIGN KEY("authUserId")
    REFERENCES "serverpod_auth_core_user"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


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
